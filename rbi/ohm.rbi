# typed: strong
module Ohm
  VERSION = "0.1.0"

  class ApplicationJob
    include Sidekiq::Job
  end

  class TransactionalMessagesJob < ApplicationJob
    RetryableError = Class.new(StandardError)
    DuplicateJobError = Class.new(StandardError)
    MAX_DURATION = 5.minutes

    sig { params(key: T.untyped, processor_name: T.untyped).returns(T.untyped) }
    def perform(key, processor_name = self.class.name); end

    sig { params(key: T.untyped, processor_name: T.untyped, deadline: T.untyped).returns(T.untyped) }
    def process_messages(key:, processor_name:, deadline:); end

    sig { params(message: T.untyped).returns(T.untyped) }
    def pre_process(message); end

    sig { params(message: T.untyped).returns(T.untyped) }
    def process(message); end

    sig { returns(T.untyped) }
    def message_class; end

    sig { params(key: T.untyped, processor_name: T.untyped).returns(T.untyped) }
    def next_message(key:, processor_name:); end

    sig { params(key: T.untyped, blk: T.untyped).returns(T.untyped) }
    def locking(key, &blk); end
  end

  class TransactionalMessagesPeriodicJob < ApplicationJob
    sig { returns(T.untyped) }
    def perform; end

    sig { returns(T.untyped) }
    def message_parent_class; end
  end

  module TransactionalMessage
    extend ActiveSupport::Concern

    sig { params(processor_name: T.untyped).returns(T.untyped) }
    def processed?(processor_name:); end

    sig { params(processor_name: T.untyped).returns(T.untyped) }
    def processed(processor_name:); end

    sig { params(processor_name: T.untyped).returns(T.untyped) }
    def unprocessed_predecessors(processor_name:); end

    sig { returns(T.untyped) }
    def completions; end
  end

  class ApplicationRecord < ActiveRecord::Base
  end

  class Engine < ::Rails::Engine
  end

  module QueueLocking
    extend self
    ACQUIRE_LOCK = "pg_advisory_xact_lock"
    TRY_ACQUIRE_LOCK = "pg_try_advisory_xact_lock"

    class Key
      PREFIX = "QueueLocking"

      sig { params(queue_type: T.untyped, message_type: T.untyped, message_key: T.untyped).void }
      def initialize(queue_type:, message_type:, message_key:); end

      sig { returns(T.untyped) }
      attr_reader :text

      sig { returns(T.untyped) }
      attr_reader :int64

      sig { params(message_key: T.untyped).returns(T.untyped) }
      def stringify(message_key); end

      sig { params(obj: T.untyped).returns(T.untyped) }
      def normalize(obj); end
    end

    class LockWaitTimeout < StandardError
    end

    sig do
      params(
        queue_type: T.untyped,
        message_type: T.untyped,
        message_keys: T.untyped,
        wait: T.untyped,
        blk: T.untyped
      ).returns(T.untyped)
    end
    def locking(queue_type:, message_type:, message_keys:, wait: true, &blk); end

    sig { params(key: T.untyped, wait: T.untyped, blk: T.untyped).returns(T.untyped) }
    def with_lock(key:, wait:, &blk); end

    sig { params(key: T.untyped).returns(T.untyped) }
    def lock(key:); end

    sig { params(key: T.untyped).returns(T.untyped) }
    def try_lock(key:); end

    sig { params(fn: T.untyped, key: T.untyped).returns(T.untyped) }
    def sql(fn:, key:); end

    sig { returns(T.untyped) }
    def connection; end
  end

  module Inbox
    class MessagesPeriodicJob < TransactionalMessagesPeriodicJob
      sig { returns(T.untyped) }
      def message_parent_class; end
    end

    sig { returns(T.untyped) }
    def self.table_name_prefix; end

    class Completion < ApplicationRecord
    end

    class Message < ApplicationRecord
      include TransactionalMessage
      QUEUE = "INBOX_QUEUE"
      COMPLETION = ::Ohm::Inbox::Completion

      sig { params(keys: T.untyped, wait: T.untyped, blk: T.untyped).returns(T.untyped) }
      def self.locking_process_queue(keys:, wait: true, &blk); end

      sig { params(processor_name: T.untyped).returns(T.untyped) }
      def enqueue_job(processor_name = job_class.name); end

      sig { params(interval: T.untyped, processor_name: T.untyped).returns(T.untyped) }
      def perform_job_in(interval, processor_name = job_class.name); end

      sig { returns(T.untyped) }
      def job_class; end
    end
  end

  module Outbox
    class MessagesPeriodicJob < TransactionalMessagesPeriodicJob
      sig { returns(T.untyped) }
      def message_parent_class; end
    end

    sig { returns(T.untyped) }
    def self.table_name_prefix; end

    class Completion < ApplicationRecord
    end

    class Message < ApplicationRecord
      include TransactionalMessage
      PERSISTENCE_QUEUE = "OUTBOX_PERSISTENCE_QUEUE"
      TRANSMISSION_QUEUE = "OUTBOX_TRANSMISSION_QUEUE"
      COMPLETION = ::Ohm::Outbox::Completion

      sig { params(keys: T.untyped, wait: T.untyped, blk: T.untyped).returns(T.untyped) }
      def self.locking_persistence_queue(keys:, wait: true, &blk); end

      sig { params(keys: T.untyped, wait: T.untyped, blk: T.untyped).returns(T.untyped) }
      def self.locking_process_queue(keys:, wait: true, &blk); end

      sig { params(processor_name: T.untyped).returns(T.untyped) }
      def enqueue_job(processor_name = job_class.name); end

      sig { params(interval: T.untyped, processor_name: T.untyped).returns(T.untyped) }
      def perform_job_in(interval, processor_name = job_class.name); end

      sig { returns(T.untyped) }
      def job_class; end
    end
  end
end
