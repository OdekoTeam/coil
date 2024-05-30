# typed: strict
# frozen_string_literal: true

module Ohm
  module Outbox
    class Message < ApplicationRecord
      PERSISTENCE_QUEUE = "OUTBOX_PERSISTENCE_QUEUE"
      PROCESS_QUEUE = "OUTBOX_PROCESS_QUEUE"

      COMPLETION = ::Ohm::Outbox::Completion

      include TransactionalMessage

      after_commit :enqueue_job, on: :create

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
