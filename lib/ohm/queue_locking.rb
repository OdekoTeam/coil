# frozen_string_literal: true

module Ohm
  module QueueLocking
    extend self

    class Key
      PREFIX = "QueueLocking"

      # Construct a key suitable for obtaining a PostgreSQL advisory lock.
      # https://www.postgresql.org/docs/current/explicit-locking.html#ADVISORY-LOCKS
      def initialize(queue_type:, message_type:, message_key:)
        @text = [PREFIX, queue_type, message_type, normalize(message_key)].join("|")
        @int64 = Digest::SHA256.digest(@text).slice(0, 8).unpack1("q")
      end

      attr_reader :text
      attr_reader :int64

      private

      def normalize(message_key)
        if message_key.is_a?(Hash)
          JSON.generate(deep_normalize(message_key))
        else
          message_key
        end
      end

      def deep_normalize(obj)
        if obj.is_a?(Hash)
          obj.stringify_keys.sort.map { |k, v| [k, deep_normalize(v)] }.to_h
        else
          obj
        end
      end
    end

    class LockWaitTimeout < StandardError
    end

    # Run an action while holding advisory locks on a list of keys for messages
    # of a given type in a given queue.
    #
    # By default, this waits until the locks can be obtained. To instead
    # raise a QueueLocking::LockWaitTimeout error if locks cannot be obtained
    # immediately, specify `wait: false`.
    def locking(queue_type:, message_type:, message_keys:, wait: true, &blk)
      keys = message_keys.compact.map do |message_key|
        Key.new(queue_type:, message_type:, message_key:)
      end

      # Acquire locks in a consistent order to avoid deadlocks.
      ks = keys.uniq(&:int64).sort_by(&:int64).reverse

      fn = ks.reduce(blk) do |f, key|
        -> do
          with_lock(key:, wait:) do
            f.call
          end
        end
      end

      ApplicationRecord.transaction { fn.call }
    end

    private

    def with_lock(key:, wait:, &blk)
      wait ? lock(key:) : try_lock(key:)
      blk.call
    end

    ACQUIRE_LOCK = "pg_advisory_xact_lock"
    TRY_ACQUIRE_LOCK = "pg_try_advisory_xact_lock"

    def lock(key:)
      command = sql(fn: ACQUIRE_LOCK, key:)
      connection.execute(command)
    rescue ActiveRecord::LockWaitTimeout
      raise LockWaitTimeout
    end

    def try_lock(key:)
      query = sql(fn: TRY_ACQUIRE_LOCK, key:)
      return if connection.select_value(query)
      raise LockWaitTimeout
    end

    def sql(fn:, key:)
      arg = key.int64
      name = SecureRandom.hex # avoid cached results
      comment = key.text.gsub(%r{(/\*)|(\*/)}, "--")

      <<~SQL.squish
        SELECT #{fn}(#{arg}) AS "#{name}" /* #{comment} */
      SQL
    end

    def connection
      ApplicationRecord.connection
    end
  end
end
