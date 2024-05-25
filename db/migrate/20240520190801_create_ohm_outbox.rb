# typed: false

class CreateOhmOutbox < ActiveRecord::Migration[6.1]
  def change
    create_table :ohm_outbox_messages do |t|
      t.string :type, null: false
      t.jsonb :key, null: false
      t.jsonb :value, null: false
      t.jsonb :metadata, null: false, default: {}

      t.timestamps

      t.index [:type, :key]
      t.index :created_at
    end

    create_table :ohm_outbox_completions do |t|
      t.string :processor_name, null: false
      t.string :message_type, null: false
      t.jsonb :message_key, null: false
      t.references(
        :last_completed_message,
        null: false,
        foreign_key: {to_table: :ohm_outbox_messages},
        index: true
      )
      t.timestamps

      t.index(
        [:processor_name, :message_type, :message_key],
        name: "index_ohm_outbox_completions_on_processor_message_type_key_uniq",
        unique: true
      )
      # Although the above unique index means there can only be a single row for
      # a given (processor_name, message_type, message_key) combo, providing an
      # additional non-unique index that includes last_completed_message_id will
      # allow some critical queries to leverage an index-only-scan (where the
      # index itself provides all the required data, eliminating the need to
      # also visit the table itself).
      t.index(
        [:processor_name, :message_type, :message_key, :last_completed_message_id],
        name: "index_ohm_outbox_completions_on_processor_message_completed"
      )
    end
  end
end
