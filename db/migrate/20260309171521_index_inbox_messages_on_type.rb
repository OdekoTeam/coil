# typed: false

class IndexInboxMessagesOnType < ActiveRecord::Migration[8.1]
  disable_ddl_transaction!

  # Indexing on `type` improves performance when a periodic job queries for all
  # distinct message types, i.e.
  #
  #   SELECT DISTINCT "type" FROM "coil_inbox_messages"
  #
  # The existing indices on `(type, key)` involve significantly more data,
  # because `key` is a jsonb column. This can (and often does) cause the query
  # planner to choose a full table scan over an index scan. The decision may
  # depend on whether database maintenance tasks (e.g. autovaccuming) have run
  # recently, and how up-to-date the database statistics are.
  #
  # A simple index on `type` provides a more efficient option, making it far
  # less likely that the query planner will choose a full table scan.

  def change
    add_index :coil_inbox_messages, :type, algorithm: :concurrently
  end
end
