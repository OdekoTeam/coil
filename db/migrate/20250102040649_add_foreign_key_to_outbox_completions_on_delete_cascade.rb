# typed: false

class AddForeignKeyToOutboxCompletionsOnDeleteCascade < ActiveRecord::Migration[6.0]
  def change
    from_table = :coil_outbox_completions
    to_table = :coil_outbox_messages
    column = :last_completed_message_id
    old_key = find_foreign_key(from_table, to_table:, column:, on_delete: nil)

    # NOTE: To minimize the impact on read/write availability while adding this
    # foreign key, we specify `validate: false`, skipping the table scan that
    # would normally be performed to validate that all existing rows satisfy the
    # new constraint. We can then validate it in a separate transaction (see the
    # next migration) without blocking reads/writes to the tables involved.
    # https://www.postgresql.org/docs/current/sql-altertable.html#SQL-ALTERTABLE-DESC-ADD-TABLE-CONSTRAINT
    add_foreign_key(
      from_table,
      to_table,
      column:,
      name: "#{old_key.name}_on_delete_cascade",
      on_delete: :cascade,
      validate: false
    )
  end

  private

  def find_foreign_key(from_table, **options)
    foreign_keys(from_table).detect { |fk| fk.defined_for?(**options) } ||
      raise("No foreign key found from table '#{from_table}' for #{options}")
  end
end
