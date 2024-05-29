# typed: false

module Ohm
  module TransactionalMessage
    extend ActiveSupport::Concern

    included do
      unless self < ActiveRecord::Base
        raise <<~ERR.squish
          Cannot include TransactionalMessage in #{self} because #{self} does not
          inherit from ActiveRecord::Base.
        ERR
      end

      unless respond_to?(:sti_name)
        raise <<~ERR.squish
          Cannot include TransactionalMessage in #{self} because #{self} does not
          use single table inheritance.
        ERR
      end

      unless const_defined?(:COMPLETION)
        raise <<~ERR.squish
          Cannot include TransactionalMessage in #{self} because
          #{self}::COMPLETION is not defined.
        ERR
      end

      unless self::COMPLETION < ActiveRecord::Base
        raise <<~ERR.squish
          Cannot include TransactionalMessage in #{self} because
          #{self}::COMPLETION does not inherit from ActiveRecord::Base.
        ERR
      end

      unless const_defined?(:PERSISTENCE_QUEUE)
        raise <<~ERR.squish
          Cannot include TransactionalMessage in #{self} because
          #{self}::PERSISTENCE_QUEUE is not defined.
        ERR
      end

      unless const_defined?(:PROCESS_QUEUE)
        raise <<~ERR.squish
          Cannot include TransactionalMessage in #{self} because
          #{self}::PROCESS_QUEUE is not defined.
        ERR
      end

      validates :key, presence: true

      attr_readonly :type, :key, :value

      around_save :locking_persistence_queue, if: :new_record?

      include PreventDestruction
    end

    def processed?(processor_name:)
      persisted? &&
        completions.exists?(processor_name:, last_completed_message_id: id...)
    end

    def processed(processor_name:)
      c = completions.find_or_initialize_by(processor_name:)
      max_id = [c.last_completed_message_id, id].compact.max
      c.update!(last_completed_message_id: max_id)
    end

    def unprocessed_predecessors(processor_name:)
      self.class.unprocessed(processor_name:).where(id: ...id, key:)
    end

    def locking_persistence_queue(wait: true, &blk)
      self.class.locking_persistence_queue(keys: [key], wait:, &blk)
    end

    class_methods do
      # Messages already processed by the given processor_name. If processor_name is
      # an array, include messages already processed by any of the named processors.
      def processed(processor_name:)
        distinct.joins(
          sanitize_sql([<<~SQL.squish, {processor_names: Array(processor_name)}])
            INNER JOIN "#{self::COMPLETION.table_name}" "completions"
              ON "completions"."processor_name" IN (:processor_names)
             AND "completions"."message_type" = "#{table_name}"."type"
             AND "completions"."message_key" = "#{table_name}"."key"
             AND "completions"."last_completed_message_id" >= "#{table_name}"."id"
          SQL
        )
      end

      # Messages not yet processed by the given processor_name. If processor_name is
      # an array, exclude messages already processed by any of the named processors.
      def unprocessed(processor_name:)
        joins(
          sanitize_sql([<<~SQL.squish, {processor_names: Array(processor_name)}])
            LEFT JOIN "#{self::COMPLETION.table_name}" "completions"
              ON "completions"."processor_name" IN (:processor_names)
             AND "completions"."message_type" = "#{table_name}"."type"
             AND "completions"."message_key" = "#{table_name}"."key"
             AND "completions"."last_completed_message_id" >= "#{table_name}"."id"
          SQL
        ).where(completions: {id: nil})
      end

      # Find the next message, with a given key, that hasn't already been processed
      # by the given processor_name. If processor_name is an array, exclude messages
      # already processed by any of the named processors.
      def next_in_line(key:, processor_name:)
        unprocessed(processor_name:).where(key:).order(id: :asc).first
      end

      def locking_persistence_queue(keys:, wait: true, &blk)
        queue_type = self::PERSISTENCE_QUEUE
        message_type = sti_name
        QueueLocking.locking(queue_type:, message_type:, message_keys: keys, wait:, &blk)
      end

      def locking_process_queue(keys:, wait: true, &blk)
        queue_type = self::PROCESS_QUEUE
        message_type = sti_name
        QueueLocking.locking(queue_type:, message_type:, message_keys: keys, wait:, &blk)
      end
    end

    private

    def completions
      self.class::COMPLETION.where(
        message_type: type,
        message_key: key
      )
    end
  end
end
