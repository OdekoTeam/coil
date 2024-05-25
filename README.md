# Ohm
<img src="./solenoid.svg" width="35%">

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

The name ([ohm](https://en.wikipedia.org/wiki/Ohm)) is borrowed from
electromagnetism, partly because it's concise.

## Installation
Add to the application's Gemfile:

```ruby
gem "ohm", source: "https://gem.odeko.com/"
gem "schema_version_cache", source: "https://gem.odeko.com/"
```

Install engine and migrations:
```console
$ bundle
$ bundle exec rails ohm:install:migrations
$ bundle exec rails db:migrate
```

Register periodic jobs:
```ruby
# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  # ...
  config.periodic do |mgr|
    mgr.register("*/10 * * * *", "Ohm::Inbox::MessagesPeriodicJob")
    mgr.register("5-59/10 * * * *", "Ohm::Outbox::MessagesPeriodicJob")
  end
end
```

Filter retryable errors out of airbrake:
```ruby
# config/initializers/airbrake.rb
Airbrake.add_filter do |notice|
  exception = notice.stash[:exception]
  notice.ignore! if exception.is_a?(Ohm::TransactionalMessagesJob::RetryableError)
end
```

Set up schema version cache as described
[here](https://github.com/OdekoTeam/schema_version_cache?tab=readme-ov-file#usage)

## Usage: inbox

Define a message type and corresponding job:
```ruby
# app/models/inbox/foo_message.rb
class Inbox::FooMessage < Ohm::Inbox::Message
  def job_class
    Inbox::FooMessagesJob
  end
end
```
```ruby
# app/jobs/inbox/foo_messages_job.rb
class Inbox::FooMessagesJob < Ohm::TransactionalMessagesJob
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
module Receivers::CustomerCommandsReceiver
  VALUE_SCHEMA_SUBJECT = "com.example.service.Foo_value"

  def self.receive(key:, value:, schema_id:)
    schema_version = AvroVersionCache.get_version_number(
      subject: VALUE_SCHEMA_SUBJECT,
      schema_id:
    )
    Inbox::NetsuiteCreditMemoMessage.create!(
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
class Outbox::BarMessage < Ohm::Outbox::Message
  VALUE_SCHEMA_SUBJECT = "com.example.Bar_value"

  def job_class
    Outbox::BarMessagesJob
  end
end
```
```ruby
# app/jobs/outbox/bar_messages_job.rb
class Outbox::BarMessagesJob < Ohm::TransactionalMessagesJob
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

Write to the outbox:
```ruby
bar = Bar.first
turnips = bar.count_turnips
Outbox::BarMessage.create!(key: bar.uuid, value: {turnips:})

# For operations that should not be allowed to run concurrently, e.g.
# if we want to ensure turnip-harvesting attempts on this bar are run
# in sequence rather than concurrently:
Outbox::BarMessage.locking_persistence_queue(keys: [bar.uuid]) do
  bar.harvest_turnips
  bar.replant
  turnips = bar.count_turnips
  Outbox::BarMessage.create!(key: bar.uuid, value: {turnips:})
end
```

## Development

Install development dependencies:
```console
$ bundle
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

The `rbi/ohm.rbi` file declares this gem's interface, allowing downstream apps
to perform static typechecks. Keeping these type annotations in a separate file
allows downstream apps to use our gem without requiring that they also have a
runtime dependency on the sorbet typechecker.
