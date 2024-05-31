# typed: true

module Ohm
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

class Ohm::ApplicationJob
  include ::Sidekiq::Job
end

class Ohm::ApplicationRecord < ::ActiveRecord::Base
end

class Ohm::Engine < ::Rails::Engine
end

module Ohm::Inbox
  class << self
    sig { returns(String) }
    def table_name_prefix; end
  end
end

class Ohm::Inbox::Completion < ::Ohm::ApplicationRecord
  include ::Ohm::PreventDestruction
end

class Ohm::Inbox::Message < ::Ohm::ApplicationRecord
  include ::Ohm::TransactionalMessage
  include ::Ohm::PreventDestruction

  abstract!

  sig { params(processor_name: String).void }
  def enqueue_job(processor_name = T.unsafe(nil)); end

  sig { abstract.returns(T.class_of(::Ohm::TransactionalMessagesJob)) }
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

Ohm::Inbox::Message::COMPLETION = Ohm::Inbox::Completion
Ohm::Inbox::Message::PERSISTENCE_QUEUE = T.let(T.unsafe(nil), String)
Ohm::Inbox::Message::PROCESS_QUEUE = T.let(T.unsafe(nil), String)

class Ohm::Inbox::MessagesPeriodicJob < ::Ohm::TransactionalMessagesPeriodicJob
  private

  sig { override.returns(T.class_of(::Ohm::Inbox::Message)) }
  def message_parent_class; end
end

module Ohm::Outbox
  class << self
    sig { returns(String) }
    def table_name_prefix; end
  end
end

class Ohm::Outbox::Completion < ::Ohm::ApplicationRecord
  include ::Ohm::PreventDestruction
end

class Ohm::Outbox::Message < ::Ohm::ApplicationRecord
  include ::Ohm::TransactionalMessage
  include ::Ohm::PreventDestruction
  extend ::Ohm::TransactionalMessage::ClassMethods

  abstract!

  sig { params(processor_name: String).void }
  def enqueue_job(processor_name = T.unsafe(nil)); end

  sig { abstract.returns(T.class_of(::Ohm::TransactionalMessagesJob)) }
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

Ohm::Outbox::Message::COMPLETION = Ohm::Outbox::Completion
Ohm::Outbox::Message::PERSISTENCE_QUEUE = T.let(T.unsafe(nil), String)
Ohm::Outbox::Message::PROCESS_QUEUE = T.let(T.unsafe(nil), String)

class Ohm::Outbox::MessagesPeriodicJob < ::Ohm::TransactionalMessagesPeriodicJob
  private

  sig { override.returns(T.class_of(::Ohm::Outbox::Message)) }
  def message_parent_class; end
end

module Ohm::PreventDestruction
  extend ::ActiveSupport::Concern

  private

  def prevent_destruction; end
end

module Ohm::QueueLocking
  include ::Kernel
  extend ::Ohm::QueueLocking
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

Ohm::QueueLocking::ACQUIRE_LOCK = T.let(T.unsafe(nil), String)

class Ohm::QueueLocking::Key
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

Ohm::QueueLocking::Key::PREFIX = T.let(T.unsafe(nil), String)

class Ohm::QueueLocking::LockWaitTimeout < ::StandardError; end

Ohm::QueueLocking::TRY_ACQUIRE_LOCK = T.let(T.unsafe(nil), String)

module Ohm::TransactionalMessage
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

module Ohm::TransactionalMessage::ClassMethods
  def locking_persistence_queue(keys:, wait: T.unsafe(nil), &blk); end
  def locking_process_queue(keys:, wait: T.unsafe(nil), &blk); end
  def next_in_line(key:, processor_name:); end
  def processed(processor_name:); end
  def unprocessed(processor_name:); end
end

class Ohm::TransactionalMessagesJob < ::Ohm::ApplicationJob
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

  sig { abstract.returns(::Ohm::AnyMessageClass) }
  def message_class; end

  sig { params(key: T.untyped, processor_name: String).returns(T.nilable(::Ohm::AnyMessage)) }
  def next_message(key:, processor_name:); end

  sig { overridable.params(message: ::Ohm::AnyMessage).void }
  def pre_process(message); end

  sig { abstract.params(message: ::Ohm::AnyMessage).void }
  def process(message); end

  sig do
    params(
      key: T.untyped,
      processor_name: String,
      deadline: ActiveSupport::TimeWithZone
    ).returns(T.nilable(::Ohm::AnyMessage))
  end
  def process_messages(key:, processor_name:, deadline:); end
end

class Ohm::TransactionalMessagesJob::DuplicateJobError < ::StandardError; end
Ohm::TransactionalMessagesJob::MAX_DURATION = T.let(T.unsafe(nil), ActiveSupport::Duration)
class Ohm::TransactionalMessagesJob::RetryableError < ::StandardError; end

class Ohm::TransactionalMessagesPeriodicJob < ::Ohm::ApplicationJob
  abstract!

  sig { void }
  def perform; end

  private

  sig { abstract.returns(::Ohm::AnyMessageClass) }
  def message_parent_class; end
end

Ohm::VERSION = T.let(T.unsafe(nil), String)
