# typed: false

class ValidateForeignKeyInboxCompletions < ActiveRecord::Migration[6.0]
  def change
    from_table = :coil_inbox_completions
    to_table = :coil_inbox_messages
    column = :last_completed_message_id
    key = find_foreign_key(from_table, to_table:, column:, on_delete: :cascade)

    validate_foreign_key from_table, to_table, name: key.name
  end

  private

  def find_foreign_key(from_table, **options)
    foreign_keys(from_table).detect { |fk| fk.defined_for?(**options) } ||
      raise("No foreign key found from table '#{from_table}' for #{options}")
  end
end
