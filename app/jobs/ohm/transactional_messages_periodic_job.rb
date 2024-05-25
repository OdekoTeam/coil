# typed: strict

# The periodic job acts as a fallback mechanism, polling for messages that were
# not enqueued and processed automatically upon create, e.g. due to a failure to
# push a job onto the Redis queue.
module Ohm
  class TransactionalMessagesPeriodicJob < ApplicationJob
    def perform
      t = Time.current - TransactionalMessagesJob::MAX_DURATION

      # Identify distinct message types, their associated job types, and
      # the distinct keys for which we have unprocessed messages (excluding
      # very recent messages, since a TransactionalMessagesJob may still be
      # processing those). Then, enqueue the necessary jobs for those keys.
      message_parent_class.select(:type).distinct.each do |x|
        message_class = x.class
        job_class = x.job_class

        message_class
          .unprocessed(processor_name: job_class.name)
          .where(created_at: nil...t)
          .distinct
          .pluck(:key)
          .each { |k| job_class.perform_async(k) }
      end
    end

    private

    def message_parent_class
    end
  end
end
