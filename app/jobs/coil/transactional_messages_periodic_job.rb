# typed: strict

# The periodic job acts as a fallback mechanism, polling for messages that were
# not enqueued and processed automatically upon create, e.g. due to a failure to
# push a job onto the Redis queue.
module Coil
  class TransactionalMessagesPeriodicJob < ApplicationJob
    def perform
      t = Time.current - TransactionalMessagesJob::MAX_DURATION

      # Identify distinct message types, their associated job types, and
      # the distinct keys for which we have unprocessed messages (excluding
      # very recent messages, since a TransactionalMessagesJob may still be
      # processing those). Then, enqueue the necessary jobs for those keys.
      message_parent_class.select(:type).distinct.pluck(:type).each do |type|
        message_class = message_class_for(type)
        next unless message_class.present?
        job_class = message_class.new.job_class

        message_class
          .unprocessed(processor_name: job_class.name)
          .where(created_at: nil...t)
          .distinct
          .pluck(:key)
          .each { |k| job_class.perform_async(k) }
      end
    end

    private

    def message_class_for(type)
      if ActiveRecord.version < Gem::Version.new("6.1.0")
        message_parent_class.send(:find_sti_class, type)
      else
        message_parent_class.sti_class_for(type)
      end
    rescue ActiveRecord::SubclassNotFound
    end

    def message_parent_class
    end
  end
end
