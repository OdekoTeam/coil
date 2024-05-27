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

      validates :key, presence: true

      # attr_readonly :key, :value, :xid
    end

    def processed?(processor_name:)
      persisted? &&
        completions.exists?(processor_name:, last_completed_message_id: id...)
    end

    def processed(processor_name:)
      c = completions.find_or_initialize_by(processor_name:)
      max_xid = [c.last_completed_message_xid, xid].compact.max
      max_id = [c.last_completed_message_id, id].compact.max
      c.update!(
        last_completed_message_xid: max_xid,
        last_completed_message_id: max_id
      )
    end

    def unprocessed_predecessors(processor_name:)
      self.class.unprocessed(processor_name:).where(id: ...id, key:)
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
        unprocessed(processor_name:)
          .ready
          .where(key:)
          .order(xid: :asc, id: :asc)
          .first
      end

      # When a newly-created message is committed to the database, the oldest
      # currently open transaction id is written to the message's "xid" column.
      #
      # Subsequent queries can compare that value against the oldest still open
      # transaction id to avoid accidentally skipping messages due to a race
      # condition.
      #
      # For example, if concurrent transactions T1 and T2 executed inserts to
      # create messages M1 and M2, but T2 commits before T1, any queries run
      # between these two commits would see M2 but not M1. We wouldn't want M2
      # to be considered a candidate for next_in_line yet.
      def ready
        # https://www.postgresql.org/docs/current/functions-info.html#FUNCTIONS-PG-SNAPSHOT-PARTS
        where(<<~SQL.squish)
          "#{table_name}"."xid" < pg_snapshot_xmin(pg_current_snapshot())
        SQL
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
