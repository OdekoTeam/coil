# typed: true

module Ohm
  class TransactionalMessagesJob < ApplicationJob
    RetryableError = Class.new(StandardError)
    DuplicateJobError = Class.new(StandardError)

    # Sidekiq is not designed for long-running jobs, so we place an upper bound
    # on job duration. When a job exceeds this bound, we'll enqueue a subsequent
    # job to pick up where we left off.
    MAX_DURATION = 5.minutes

    sidekiq_options retry: 4, dead: false

    def perform(key, processor_name = self.class.to_s)
      deadline = Time.current + MAX_DURATION
      next_in_line = process_messages(key:, processor_name:, deadline:)
      return if next_in_line.nil?

      # If we reach this point, it means we exceeded the deadline and there
      # are messages we still haven't processed.
      Rails.logger.info(<<~INFO.squish)
        #{self.class} exceeded deadline.
        Enqueuing subsequent job with key=#{key} processor_name=#{processor_name}
      INFO
      next_in_line.enqueue_job(processor_name)
    rescue DuplicateJobError
      # A duplicate job is in the midst of its message-processing loop. We'll
      # call this job done and allow the other one to continue.
    end

    private

    # Process unprocessed messages until none remain or deadline is exceeded,
    # then return the next unprocessed message, if any remain.
    def process_messages(key:, processor_name:, deadline:)
      loop do
        next_in_line = next_message(key:, processor_name:)
        return next_in_line if next_in_line.nil? || Time.current > deadline

        locking(key) do
          message = next_message(key:, processor_name:)

          if message.present?
            pre_process(message)
            message.processed(processor_name:)
            process(message)
          end
        end
      end
    end

    def pre_process(message)
    end

    def process(message)
    end

    def message_class
    end

    def next_message(key:, processor_name:)
      message_class.next_in_line(key:, processor_name:)
    end

    def locking(key, &blk)
      message_class.locking_process_queue(keys: [key], wait: false) do
        blk.call
      end
    rescue QueueLocking::LockWaitTimeout
      raise DuplicateJobError
    end
  end
end
