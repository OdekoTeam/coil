# typed: true

module Coil
  AnyMessage = T.type_alias {
    T.any(
      Inbox::Message,
      Outbox::Message
    )
  }

  AnyMessageClass = T.type_alias {
    T.any(
      T.class_of(Inbox::Message),
      T.class_of(Outbox::Message)
    )
  }
end

class Coil::ApplicationJob
  include ::Sidekiq::Worker
end

class Coil::ApplicationRecord < ::ActiveRecord::Base
end

class Coil::Engine < ::Rails::Engine
end

module Coil::Inbox
  class << self
    sig { returns(String) }
    def table_name_prefix; end
  end
end

class Coil::Inbox::Completion < ::Coil::ApplicationRecord
  include ::Coil::PreventDestruction
end

class Coil::Inbox::Message < ::Coil::ApplicationRecord
  include ::Coil::TransactionalMessage
  include ::Coil::PreventDestruction

  abstract!

  sig { params(processor_name: String).void }
  def enqueue_job(processor_name = T.unsafe(nil)); end

  sig { abstract.returns(T.class_of(::Coil::TransactionalMessagesJob)) }
  def job_class; end

  sig { params(interval: T.untyped, processor_name: String).void }
  def perform_job_in(interval, processor_name = T.unsafe(nil)); end

  class << self
    sig do
      type_parameters(:P)
        .params(
          keys: T::Array[T.untyped],
          wait: T::Boolean,
          blk: T.proc.returns(T.type_parameter(:P))
        ).returns(T.type_parameter(:P))
    end
    def locking_persistence_queue(keys:, wait: true, &blk); end

    sig do
      type_parameters(:P)
        .params(
          keys: T::Array[T.untyped],
          wait: T::Boolean,
          blk: T.proc.returns(T.type_parameter(:P))
        ).returns(T.type_parameter(:P))
    end
    def locking_process_queue(keys:, wait: true, &blk); end
  end
end

Coil::Inbox::Message::COMPLETION = Coil::Inbox::Completion
Coil::Inbox::Message::PERSISTENCE_QUEUE = T.let(T.unsafe(nil), String)
Coil::Inbox::Message::PROCESS_QUEUE = T.let(T.unsafe(nil), String)

class Coil::Inbox::MessagesCleanupJob < ::Coil::TransactionalMessagesCleanupJob
  private

  sig { override.returns(T.class_of(::Coil::Inbox::Message)) }
  def message_parent_class; end

  sig { override.returns(ActiveSupport::Duration) }
  def retention_period; end
end

class Coil::Inbox::MessagesPeriodicJob < ::Coil::TransactionalMessagesPeriodicJob
  private

  sig { override.returns(T.class_of(::Coil::Inbox::Message)) }
  def message_parent_class; end
end

module Coil::Outbox
  class << self
    sig { returns(String) }
    def table_name_prefix; end
  end
end

class Coil::Outbox::Completion < ::Coil::ApplicationRecord
  include ::Coil::PreventDestruction
end

class Coil::Outbox::Message < ::Coil::ApplicationRecord
  include ::Coil::TransactionalMessage
  include ::Coil::PreventDestruction
  extend ::Coil::TransactionalMessage::ClassMethods

  abstract!

  sig { params(processor_name: String).void }
  def enqueue_job(processor_name = T.unsafe(nil)); end

  sig { abstract.returns(T.class_of(::Coil::TransactionalMessagesJob)) }
  def job_class; end

  sig { params(interval: T.untyped, processor_name: String).void }
  def perform_job_in(interval, processor_name = T.unsafe(nil)); end

  class << self
    sig do
      type_parameters(:P)
        .params(
          keys: T::Array[T.untyped],
          wait: T::Boolean,
          blk: T.proc.returns(T.type_parameter(:P))
        ).returns(T.type_parameter(:P))
    end
    def locking_persistence_queue(keys:, wait: true, &blk); end

    sig do
      type_parameters(:P)
        .params(
          keys: T::Array[T.untyped],
          wait: T::Boolean,
          blk: T.proc.returns(T.type_parameter(:P))
        ).returns(T.type_parameter(:P))
    end
    def locking_process_queue(keys:, wait: true, &blk); end
  end
end

Coil::Outbox::Message::COMPLETION = Coil::Outbox::Completion
Coil::Outbox::Message::PERSISTENCE_QUEUE = T.let(T.unsafe(nil), String)
Coil::Outbox::Message::PROCESS_QUEUE = T.let(T.unsafe(nil), String)

class Coil::Outbox::MessagesCleanupJob < ::Coil::TransactionalMessagesCleanupJob
  private

  sig { override.returns(T.class_of(::Coil::Outbox::Message)) }
  def message_parent_class; end

  sig { override.returns(ActiveSupport::Duration) }
  def retention_period; end
end

class Coil::Outbox::MessagesPeriodicJob < ::Coil::TransactionalMessagesPeriodicJob
  private

  sig { override.returns(T.class_of(::Coil::Outbox::Message)) }
  def message_parent_class; end
end

module Coil::PreventDestruction
  extend ::ActiveSupport::Concern

  private

  def prevent_destruction; end
end

module Coil::QueueLocking
  include ::Kernel
  extend ::Coil::QueueLocking
  extend self

  sig do
    type_parameters(:P)
      .params(
        queue_type: String,
        message_type: String,
        message_keys: T::Array[T.untyped],
        wait: T::Boolean,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
  end
  def locking(queue_type:, message_type:, message_keys:, wait: T.unsafe(nil), &blk); end

  private

  sig { returns(ActiveRecord::ConnectionAdapters::AbstractAdapter) }
  def connection; end

  sig { params(key: Key).void }
  def lock(key:); end

  sig { params(fn: String, key: Key).returns(String) }
  def sql(fn:, key:); end

  sig { params(key: Key).void }
  def try_lock(key:); end

  sig do
    type_parameters(:P)
      .params(
        key: Key,
        wait: T::Boolean,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
  end
  def with_lock(key:, wait:, &blk); end
end

Coil::QueueLocking::ACQUIRE_LOCK = T.let(T.unsafe(nil), String)

class Coil::QueueLocking::Key
  sig { params(queue_type: String, message_type: String, message_key: T.untyped).void }
  def initialize(queue_type:, message_type:, message_key:); end

  def int64; end

  def text; end

  private

  sig { params(obj: T.untyped).returns(T.untyped) }
  def normalize(obj); end

  sig { params(message_key: T.untyped).returns(String) }
  def stringify(message_key); end
end

Coil::QueueLocking::Key::PREFIX = T.let(T.unsafe(nil), String)

class Coil::QueueLocking::LockWaitTimeout < ::StandardError; end

Coil::QueueLocking::TRY_ACQUIRE_LOCK = T.let(T.unsafe(nil), String)

module Coil::TransactionalMessage
  extend ::ActiveSupport::Concern

  sig do
    type_parameters(:P)
      .params(
        wait: T::Boolean,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
  end
  def locking_persistence_queue(wait: T.unsafe(nil), &blk); end

  sig { params(processor_name: String).void }
  def processed(processor_name:); end

  sig { params(processor_name: String).returns(T::Boolean) }
  def processed?(processor_name:); end

  sig { params(processor_name: String).returns(ActiveRecord::Relation) }
  def unprocessed_predecessors(processor_name:); end

  private

  sig { returns(ActiveRecord::Relation) }
  def completions; end
end

module Coil::TransactionalMessage::ClassMethods
  def locking_persistence_queue(keys:, wait: T.unsafe(nil), &blk); end
  def locking_process_queue(keys:, wait: T.unsafe(nil), &blk); end
  def next_in_line(key:, processor_name:); end
  def processed(processor_name:); end
  def unprocessed(processor_name:); end
end

class Coil::TransactionalMessagesJob < ::Coil::ApplicationJob
  abstract!

  sig { params(key: T.untyped, processor_name: String).void }
  def perform(key, processor_name = T.unsafe(nil)); end

  private

  sig do
    type_parameters(:P)
      .params(
        key: T.untyped,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
  end
  def locking(key, &blk); end

  sig { abstract.returns(::Coil::AnyMessageClass) }
  def message_class; end

  sig { params(key: T.untyped, processor_name: String).returns(T.nilable(::Coil::AnyMessage)) }
  def next_message(key:, processor_name:); end

  sig do
    overridable
      .type_parameters(:P)
      .params(
        message: ::Coil::AnyMessage,
        processor_name: String,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
  end
  def around_process(message, processor_name:, &blk); end

  sig { overridable.params(message: ::Coil::AnyMessage).void }
  def pre_process(message); end

  sig { abstract.params(message: ::Coil::AnyMessage).void }
  def process(message); end

  sig do
    params(
      key: T.untyped,
      processor_name: String,
      deadline: ActiveSupport::TimeWithZone
    ).returns(T.nilable(::Coil::AnyMessage))
  end
  def process_messages(key:, processor_name:, deadline:); end
end

class Coil::TransactionalMessagesJob::DuplicateJobError < ::StandardError; end
Coil::TransactionalMessagesJob::MAX_DURATION = T.let(T.unsafe(nil), ActiveSupport::Duration)
class Coil::TransactionalMessagesJob::RetryableError < ::StandardError; end

class Coil::TransactionalMessagesCleanupJob < ::Coil::ApplicationJob
  abstract!

  class DuplicateJobError < ::StandardError; end

  MAX_DURATION = T.let(T.unsafe(nil), ActiveSupport::Duration)

  sig { params(batch_size: Integer).void }
  def perform(batch_size = 1000); end

  private

  Result = T.type_alias { T.any(Finished, ExceededDeadline) }

  sig { params(batch_size: Integer).returns(Result) }
  def delete_messages(batch_size); end

  sig { params(batch_size: Integer).returns(Result) }
  def _delete_messages(batch_size); end

  QUEUE_TYPE = T.let(T.unsafe(nil), String)

  sig {
    type_parameters(:P)
      .params(blk: T.proc.returns(T.type_parameter(:P)))
      .returns(T.type_parameter(:P))
  }
  def locking(&blk); end

  sig { params(type: String).returns(T.nilable(::Coil::AnyMessageClass)) }
  def message_class_for(type); end

  sig { abstract.returns(::Coil::AnyMessageClass) }
  def message_parent_class; end

  sig { abstract.returns(ActiveSupport::Duration) }
  def retention_period; end
end

class Coil::TransactionalMessagesPeriodicJob < ::Coil::ApplicationJob
  abstract!

  sig { void }
  def perform; end

  private

  sig { abstract.returns(::Coil::AnyMessageClass) }
  def message_parent_class; end
end

Coil::VERSION = T.let(T.unsafe(nil), String)
