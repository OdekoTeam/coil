# typed: strong

# NOTE: This file was first generated by parlour, then edited to fill in more
# accurate type signatures. Regenerating (`bundle exec parlour`) will wipe out
# those edits, e.g. reverting all params and return types to `T.untyped`.
module Ohm
  VERSION = "0.1.0"

  class ApplicationJob
    include Sidekiq::Job
  end

  # NOTE: These type aliases are not visible outside of this file.
  # See spec/dummy/app/lib/type_aliases.rb
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

  class TransactionalMessagesJob < ApplicationJob
    abstract!

    RetryableError = Class.new(StandardError)
    DuplicateJobError = Class.new(StandardError)
    MAX_DURATION = 5.minutes

    sig { params(key: T.untyped, processor_name: String).void }
    def perform(key, processor_name = self.class.to_s); end

    sig do
      params(
        key: T.untyped,
        processor_name: String,
        deadline: ActiveSupport::TimeWithZone
      ).returns(
        T.nilable(AnyMessage)
      )
    end
    def process_messages(key:, processor_name:, deadline:); end

    sig do
      overridable.params(message: AnyMessage).void
    end
    def pre_process(message); end

    sig do
      abstract.params(message: AnyMessage).void
    end
    def process(message); end

    sig { abstract.returns(AnyMessageClass) }
    def message_class; end

    sig do
      params(
        key: T.untyped,
        processor_name: String
      ).returns(
        T.nilable(AnyMessage)
      )
    end
    def next_message(key:, processor_name:); end

    sig do
      type_parameters(:P).params(
        key: T.untyped,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
    end
    def locking(key, &blk); end
  end

  class TransactionalMessagesPeriodicJob < ApplicationJob
    abstract!

    sig { void }
    def perform; end

    sig { abstract.returns(AnyMessageClass) }
    def message_parent_class; end
  end

  module TransactionalMessage
    extend ActiveSupport::Concern

    sig { params(processor_name: String).returns(T::Boolean) }
    def processed?(processor_name:); end

    sig { params(processor_name: String).void }
    def processed(processor_name:); end

    sig { params(processor_name: String).returns(ActiveRecord::Relation) }
    def unprocessed_predecessors(processor_name:); end

    sig do
      type_parameters(:P).params(
        wait: T::Boolean,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
    end
    def locking_persistence_queue(wait: true, &blk); end

    sig { returns(ActiveRecord::Relation) }
    def completions; end
  end

  class ApplicationRecord < ActiveRecord::Base
  end

  class Engine < ::Rails::Engine
  end

  module QueueLocking
    include Kernel
    extend self
    ACQUIRE_LOCK = "pg_advisory_xact_lock"
    TRY_ACQUIRE_LOCK = "pg_try_advisory_xact_lock"

    class Key
      PREFIX = "QueueLocking"

      sig do
        params(queue_type: String, message_type: String, message_key: T.untyped).void
      end
      def initialize(queue_type:, message_type:, message_key:); end

      sig { returns(String) }
      attr_reader :text

      sig { returns(Integer) }
      attr_reader :int64

      sig { params(message_key: T.untyped).returns(String) }
      def stringify(message_key); end

      sig { params(obj: T.untyped).returns(T.untyped) }
      def normalize(obj); end
    end

    class LockWaitTimeout < StandardError
    end

    sig do
      type_parameters(:P).params(
        queue_type: String,
        message_type: String,
        message_keys: T::Array[T.untyped],
        wait: T::Boolean,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
    end
    def locking(queue_type:, message_type:, message_keys:, wait: true, &blk); end

    sig do
      type_parameters(:P).params(
        key: Key,
        wait: T::Boolean,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
    end
    def with_lock(key:, wait:, &blk); end

    sig { params(key: Key).void }
    def lock(key:); end

    sig { params(key: Key).void }
    def try_lock(key:); end

    sig { params(fn: String, key: Key).returns(String) }
    def sql(fn:, key:); end

    sig { returns(ActiveRecord::ConnectionAdapters::AbstractAdapter) }
    def connection; end
  end

  module Inbox
    class MessagesPeriodicJob < TransactionalMessagesPeriodicJob
      sig { override.returns(T.class_of(Inbox::Message)) }
      def message_parent_class; end
    end

    sig { returns(String) }
    def self.table_name_prefix; end

    class Completion < ApplicationRecord
    end

    class Message < ApplicationRecord
      abstract!

      include TransactionalMessage
      PERSISTENCE_QUEUE = "INBOX_PERSISTENCE_QUEUE"
      PROCESS_QUEUE = "INBOX_PROCESS_QUEUE"
      COMPLETION = ::Ohm::Inbox::Completion

      sig do
        type_parameters(:P).params(
          keys: T::Array[T.untyped],
          wait: T::Boolean,
          blk: T.proc.returns(T.type_parameter(:P))
        ).returns(T.type_parameter(:P))
      end
      def self.locking_persistence_queue(keys:, wait: true, &blk); end

      sig do
        type_parameters(:P).params(
          keys: T::Array[T.untyped],
          wait: T::Boolean,
          blk: T.proc.returns(T.type_parameter(:P))
        ).returns(T.type_parameter(:P))
      end
      def self.locking_process_queue(keys:, wait: true, &blk); end

      sig { params(processor_name: String).void }
      def enqueue_job(processor_name = job_class.to_s); end

      sig { params(interval: T.untyped, processor_name: String).void }
      def perform_job_in(interval, processor_name = job_class.to_s); end

      sig { abstract.returns(T.class_of(TransactionalMessagesJob)) }
      def job_class; end
    end
  end

  module Outbox
    class MessagesPeriodicJob < TransactionalMessagesPeriodicJob
      sig { override.returns(T.class_of(Outbox::Message)) }
      def message_parent_class; end
    end

    sig { returns(String) }
    def self.table_name_prefix; end

    class Completion < ApplicationRecord
    end

    class Message < ApplicationRecord
      abstract!

      include TransactionalMessage
      PERSISTENCE_QUEUE = "OUTBOX_PERSISTENCE_QUEUE"
      PROCESS_QUEUE = "OUTBOX_PROCESS_QUEUE"
      COMPLETION = ::Ohm::Outbox::Completion

      sig do
        type_parameters(:P).params(
          keys: T::Array[T.untyped],
          wait: T::Boolean,
          blk: T.proc.returns(T.type_parameter(:P))
        ).returns(T.type_parameter(:P))
      end
      def self.locking_persistence_queue(keys:, wait: true, &blk); end

      sig do
        type_parameters(:P).params(
          keys: T::Array[T.untyped],
          wait: T::Boolean,
          blk: T.proc.returns(T.type_parameter(:P))
        ).returns(T.type_parameter(:P))
      end
      def self.locking_process_queue(keys:, wait: true, &blk); end

      sig { params(processor_name: String).void }
      def enqueue_job(processor_name = job_class.to_s); end

      sig { params(interval: T.untyped, processor_name: String).void }
      def perform_job_in(interval, processor_name = job_class.to_s); end

      sig { abstract.returns(T.class_of(TransactionalMessagesJob)) }
      def job_class; end
    end
  end
end
