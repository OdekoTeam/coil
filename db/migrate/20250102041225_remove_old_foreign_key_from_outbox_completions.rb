# typed: false

class RemoveOldForeignKeyFromOutboxCompletions < ActiveRecord::Migration[6.0]
  def change
    from_table = :coil_outbox_completions
    to_table = :coil_outbox_messages
    column = :last_completed_message_id
    new_key = find_foreign_key(from_table, to_table:, column:, on_delete: :cascade)

    remove_foreign_key(
      from_table,
      to_table,
      column:,
      name: new_key.name.delete_suffix("_on_delete_cascade")
    )
  end

  private

  def find_foreign_key(from_table, **options)
    foreign_keys(from_table).detect { |fk| fk.defined_for?(**options) } ||
      raise("No foreign key found from table '#{from_table}' for #{options}")
  end
end
