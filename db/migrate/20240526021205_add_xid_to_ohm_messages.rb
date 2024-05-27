# typed: false

class AddXidToOhmMessages < ActiveRecord::Migration[6.1]
  def change
    # TODO:
    # - adjust indexes
    # - verify whether this works in Rails 6.x
    # - extract to a gem
    #   - reference: https://github.com/alassek/activerecord-pg_enum
    # - submit upstream
    [
      :ohm_inbox_messages,
      :ohm_outbox_messages
    ].each do |table|
      add_column(
        table,
        :xid,
        :xid8,
        null: false,
        default: -> { "pg_snapshot_xmin(pg_current_snapshot())" }
      )
      add_index table, :xid
    end

    [
      :ohm_inbox_completions,
      :ohm_outbox_completions
    ].each do |table|
      add_column(
        table,
        :last_completed_message_xid,
        :xid8,
        null: false
      )
      add_index table, :last_completed_message_xid
    end
  end
end
