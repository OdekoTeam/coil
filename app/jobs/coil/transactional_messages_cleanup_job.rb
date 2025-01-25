# typed: strict
# frozen_string_literal: true

# A cleanup job deletes processed messages whose retention period has passed.
module Coil
  class TransactionalMessagesCleanupJob < ApplicationJob
    DuplicateJobError = Class.new(StandardError)

    # Sidekiq is not designed for long-running jobs, so we place an upper bound
    # on job duration. When a job exceeds this bound, we'll enqueue a subsequent
    # job to pick up where we left off.
    MAX_DURATION = 5.minutes

    sidekiq_options retry: 4, dead: false

    def perform(batch_size = 1000)
      result = delete_messages(batch_size)
      total_deletions = result.deletions.values.sum
      deletions_json = result.deletions.to_json

      case result
      when Finished
        Rails.logger.info(<<~INFO.squish)
          #{self.class} finished after deleting #{total_deletions} messages
          (#{deletions_json}).
        INFO
      when ExceededDeadline
        Rails.logger.info(<<~INFO.squish)
          #{self.class} exceeded deadline after deleting #{total_deletions}
          messages (#{deletions_json}). Enqueuing subsequent job.
        INFO
        self.class.perform_async(batch_size)
      end
    rescue DuplicateJobError
      # A duplicate job is in the midst of its message-deletion loop. We'll call
      # this job done and allow the other one to continue.
    end

    private

    def delete_messages(batch_size)
      ApplicationRecord.uncached do
        locking do
          _delete_messages(batch_size)
        end
      end
    end

    Finished = Struct.new(:deletions)
    ExceededDeadline = Struct.new(:deletions)

    def _delete_messages(batch_size)
      now = Time.current
      created_before = now - retention_period
      deadline = now + MAX_DURATION
      deletions = Hash.new(0)

      # Identify distinct message types, their associated job types, and the
      # processed messages that can safely be deleted. Delete in batches until
      # finished or the deadline is exceeded.
      message_parent_class.select(:type).distinct.each do |x|
        message_class = x.class
        job_class = x.job_class

        message_class
          .processed(processor_name: job_class.name)
          .where(created_at: nil...created_before)
          .in_batches(of: batch_size) do |batch|
            return ExceededDeadline.new(deletions) if Time.current > deadline
            deletions[message_class.to_s] += batch.distinct(false).delete_all
          end
      end

      Finished.new(deletions)
    end

    QUEUE_TYPE = "CLEANUP_QUEUE"

    def locking(&blk)
      QueueLocking.locking(
        queue_type: QUEUE_TYPE,
        message_type: message_parent_class.to_s,
        message_keys: [self.class.to_s],
        wait: false,
        &blk
      )
    rescue QueueLocking::LockWaitTimeout
      raise DuplicateJobError
    end

    def message_parent_class
    end

    def retention_period
    end
  end
end
