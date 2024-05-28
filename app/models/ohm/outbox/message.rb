# typed: strict
# frozen_string_literal: true

module Ohm
  module Outbox
    class Message < ApplicationRecord
      PERSISTENCE_QUEUE = "OUTBOX_PERSISTENCE_QUEUE"
      TRANSMISSION_QUEUE = "OUTBOX_TRANSMISSION_QUEUE"

      COMPLETION = ::Ohm::Outbox::Completion

      include TransactionalMessage

      after_commit :enqueue_job, on: :create

      def self.locking_persistence_queue(keys:, wait: true, &blk)
        queue_type = PERSISTENCE_QUEUE
        message_type = sti_name
        QueueLocking.locking(queue_type:, message_type:, message_keys: keys, wait:) do
          blk.call
        end
      end

      def self.locking_process_queue(keys:, wait: true, &blk)
        queue_type = TRANSMISSION_QUEUE
        message_type = sti_name
        QueueLocking.locking(queue_type:, message_type:, message_keys: keys, wait:) do
          blk.call
        end
      end

      def enqueue_job(processor_name = job_class.to_s)
        perform_job_in(0.seconds, processor_name)
      end

      def perform_job_in(interval, processor_name = job_class.to_s)
        job_class.perform_in(interval, key, processor_name)
      end

      def job_class
      end
    end
  end
end
