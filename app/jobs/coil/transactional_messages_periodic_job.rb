# typed: strict

require "sidekiq/api"

# The periodic job acts as a fallback mechanism, polling for messages that were
# not enqueued and processed automatically upon create, e.g. due to a failure to
# push a job onto the Redis queue.
module Coil
  class TransactionalMessagesPeriodicJob < ApplicationJob
    ATTEMPTS_THRESHOLD = 3

    def perform
      q = Sidekiq::Queue.new(Coil.sidekiq_queue)
      t = Time.current - q.latency - TransactionalMessagesJob::MAX_DURATION

      # Identify distinct message types, their associated job types, and
      # the distinct keys for which we have unprocessed messages.
      #
      # Exclude very recent messages, since a TransactionalMessagesJob could
      # still be processing those.
      #
      # Exclude keys where a processor has already initiated several attempts,
      # since that's a strong indicator that automatic retries are in play.
      #
      # Then, enqueue the appropriate jobs.
      message_parent_class.select(:type).distinct.pluck(:type).each do |type|
        message_class = message_class_for(type)
        next unless message_class.present?
        job_class = message_class.new.job_class

        message_class
          .unprocessed(processor_name: job_class.name)
          .where(created_at: nil...t)
          .group(:key)
          .having("MAX(processor_attempts) < ?", ATTEMPTS_THRESHOLD)
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
