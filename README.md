# Coil [![concourse.odeko.com](https://concourse.odeko.com/api/v1/teams/main/pipelines/coil-main/jobs/test/badge)](https://concourse.odeko.com/teams/main/pipelines/coil-main)

<img src="https://raw.githubusercontent.com/OdekoTeam/coil/main/solenoid.svg" width="35%">

Transactional inbox/outbox message queuing.

This Rails engine can be mounted in any PostgreSQL-backed Rails app.

# Motivation
The motivating use-case involves event-streaming with Kafka.

Kafka guarantees that messages on the same topic and partition will be read
in the same order as written, but we need to ensure we're writing them in the
correct order, regardless of any concurrent processes we may be running.

Similarly, once we've read a message from the stream, we'd like to hand off the
message processing to an asynchronous job while ensuring we process messages of
a given type and key in the same order as read.

## Implementation
The [inbox/outbox](https://en.wikipedia.org/wiki/Inbox_and_outbox_pattern) pattern
(see also [article](https://microservices.io/patterns/data/transactional-outbox.html))
ensures message delivery.

Message ordering is preserved using
[advisory locks](https://www.postgresql.org/docs/current/explicit-locking.html#ADVISORY-LOCKS)
as a synchronization mechanism.

## Installation
Add to the application's Gemfile:

```ruby
gem "coil"
gem "schema_version_cache"
```

Install engine and migrations:
```console
$ bundle
$ bundle exec rails coil:install:migrations
$ bundle exec rails db:migrate
```

Register periodic jobs:
```ruby
# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  # ...
  config.periodic do |mgr|
    mgr.register("*/10 * * * *", "Coil::Inbox::MessagesPeriodicJob")
    mgr.register("5-59/10 * * * *", "Coil::Outbox::MessagesPeriodicJob")
  end
end
```

Filter retryable errors out of alerting, e.g. airbrake:
```ruby
# config/initializers/airbrake.rb
Airbrake.add_filter do |notice|
  exception = notice.stash[:exception]
  notice.ignore! if exception.is_a?(Coil::TransactionalMessagesJob::RetryableError)
end
```

Set up schema version cache as described
[here](https://github.com/OdekoTeam/schema_version_cache?tab=readme-ov-file#usage)

## Usage: inbox

Define a message type and corresponding job:
```ruby
# app/models/inbox/foo_message.rb
class Inbox::FooMessage < Coil::Inbox::Message
  def job_class
    Inbox::FooMessagesJob
  end
end
```
```ruby
# app/jobs/inbox/foo_messages_job.rb
class Inbox::FooMessagesJob < Coil::TransactionalMessagesJob
  private

  # Put message processing logic in this method.
  def process(message)
    # For example...
    uuid = message.key
    val = message.value.deep_symbolize_keys
    Foo.do_stuff(uuid:, potato: val[:potato])
  end

  def message_class
    Inbox::FooMessage
  end
end
```
(The test-suite contains a working example with type-annotations:
[message](./spec/dummy/app/models/dummy/inbox/foo_message.rb),
[job](./spec/dummy/app/jobs/dummy/inbox/foo_messages_job.rb))

(For advanced use-cases, you can also define an `around_process` job method.
[See example](./spec/dummy/app/jobs/dummy/inbox/who_messages_job.rb))

Receive messages from Kafka:
```ruby
# app/consumers/my_consumer.rb
class MyConsumer < Racecar::Consumer
  FOO = "com.example.service.foo".freeze
  subscribes_to FOO

  def process(message)
    key = AvroMessaging.decode(message.key)
    decoded = AvroMessaging.decode_message(message.value)
    value = decoded.message.deep_symbolize_keys
    schema_id = decoded.schema_id

    case message.topic
    when FOO
      Receivers::FooReceiver.receive(key:, value:, schema_id:)
    end
  end
end
```
```ruby
# app/lib/receivers/foo_receiver.rb
module Receivers::FooReceiver
  VALUE_SCHEMA_SUBJECT = "com.example.service.Foo_value"

  def self.receive(key:, value:, schema_id:)
    schema_version = AvroVersionCache.get_version_number(
      subject: VALUE_SCHEMA_SUBJECT,
      schema_id:
    )
    Inbox::FooMessage.create!(
      key:,
      value:,
      metadata: {
        value_schema_subject: VALUE_SCHEMA_SUBJECT,
        value_schema_version: schema_version,
        value_schema_id: schema_id
      }
    )
  end
end
```

## Usage: outbox

Define a message type and corresponding job:
```ruby
# app/models/outbox/bar_message.rb
class Outbox::BarMessage < Coil::Outbox::Message
  VALUE_SCHEMA_SUBJECT = "com.example.Bar_value"

  def job_class
    Outbox::BarMessagesJob
  end
end
```
```ruby
# app/jobs/outbox/bar_messages_job.rb
class Outbox::BarMessagesJob < Coil::TransactionalMessagesJob
  private

  # Attach schema metadata to message
  def pre_process(message)
    value_schema_subject = Outbox::BarMessage::VALUE_SCHEMA_SUBJECT
    value_schema_id = AvroVersionCache.get_current_id(subject: value_schema_subject)
    value_schema_version = AvroVersionCache.get_version_number(
      subject: value_schema_subject,
      schema_id: value_schema_id
    )
    metadata = {
      value_schema_subject:,
      value_schema_id:,
      value_schema_version:
    }.merge(message.metadata)

    message.update!(metadata:)
  end

  # Write message to Kafka
  def process(message)
    BarEvent.new(message).produce_async
  end

  def message_class
    Outbox::BarMessage
  end
end
```
(The test-suite contains a working example with type-annotations:
[message](./spec/dummy/app/models/dummy/outbox/bar_message.rb),
[job](./spec/dummy/app/jobs/dummy/outbox/bar_messages_job.rb))

Write to the outbox:
```ruby
bar = Bar.first
turnips = bar.count_turnips
Outbox::BarMessage.create!(key: bar.uuid, value: {turnips:})
```

## Usage: queue locking
The inbox and outbox operations described above automatically preserve message
ordering by sequentializing the creation and processing of messages with a given
type and key.

You can access these synchronization mechanisms directly if necessary:
```ruby
# If we want to treat turnip-harvesting and message creation as one operation
# and ensure that concurrent attempts to run that operation on the same Bar will
# be run sequentially:
Outbox::BarMessage.locking_persistence_queue(keys: [bar.uuid]) do
  bar.harvest_turnips
  bar.replant
  turnips = bar.count_turnips
  Outbox::BarMessage.create!(key: bar.uuid, value: {turnips:})
end

# More generally, we can run an action while holding advisory locks on a list of
# keys in some arbitrary keyspace:
queue_type = "FOOD_PREP"
message_type = "SOUP"
ingredients = ["lentils", "tomato"]
Coil::QueueLocking.locking(queue_type:, message_type:, message_keys: ingredients) do
  Chef.make_soup(ingredients)
end

# The `locking` call above will wait until it's able to obtain the requested
# lock. If we'd rather abort the operation than wait for the lock:
Coil::QueueLocking.locking(queue_type:, message_type:, message_keys: ingredients, wait: false) do
  Chef.make_soup(ingredients)
rescue Coil::QueueLocking::LockWaitTimeout
  puts("Looks like someone else is already on it")
end
```

## Configuration

To adjust the configurable settings used within your application, create an
initializer at `config/initializers/coil.rb` with the following content, then
uncomment and adjust the settings you wish to change:
```ruby
# Coil.sidekiq_queue = "default"
```

## Development

Install development dependencies:
```console
$ bundle
```

Install pre-commit hook:
```console
$ bin/install-pre-commit
```

Setup database:
```console
$ bin/rails db:setup
$ bin/rails db:migrate
```

Run test-suite:
```console
$ bin/ci-test
```

Run linter:
```console
$ bin/lint
```

Regenerate type info for DSLs (e.g. after adding a db migration):
```console
$ bin/tapioca dsl --app-root=spec/dummy
```

Regenerate type info for gems (e.g. after adding a gem):
```console
$ bin/tapioca gem
```

Coil's type annotations are declared in `rbi/coil.rbi` to facilitate typechecking
by Rails apps that use this engine along with Sorbet. Keeping these annotations
in a separate file avoids foisting a Sorbet runtime dependency on any app that
uses our engine.
