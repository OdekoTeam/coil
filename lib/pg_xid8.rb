# typed: false

require "active_record"

# PostgreSQL 13 introduced xid8, an unsigned 64-bit integer type. It is
# used to provide each transaction with a sequential identifier.
#
# https://github.com/postgres/postgres/commit/aeec457de8a8820368e343e791accffe24dc7198
# https://www.postgresql.org/docs/current/transaction-id.html
#
# A database that processed 1,000,000 transactions per second would take 584,542
# years to exhaust this range.
module PgXid8
  module Type
    class Xid8 < ::ActiveModel::Type::Integer
      def type
        :xid8
      end

      private

      def max_value
        # exclusive upper bound
        0x10000000000000000 # 2**64
      end

      def min_value
        0
      end

      def _limit
        8 # bytes
      end
    end
  end

  module Column
    # Create an xid8 column inside a table statement, e.g.
    #
    #   create_table :messages do |t|
    #     t.xid8 :transaction_id
    #   end
    #
    def xid8(name, **options)
      column(name, :xid8, **options)
    end
  end

  module InitializeTypeMap
    def initialize_type_map(m)
      super(m)
      m.register_type("xid8", ::PgXid8::Type::Xid8.new)
    end
  end
end

ActiveSupport.on_load(:active_record) do
  require "active_record/connection_adapters/postgresql_adapter"

  # Satisfy the typechecker, which is unaware of PostgreSQLAdapter.
  unless defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter)
    module ActiveRecord::ConnectionAdapters
      class PostgreSQLAdapter < AbstractAdapter
        NATIVE_DATABASE_TYPES = {}
      end
    end
  end

  # This eliminates a warning in ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
  # https://github.com/rails/rails/blob/747a03ba7722b6f0a7ce42e86cea83cf07a2e6ef/activerecord/lib/active_record/connection_adapters/postgresql_adapter.rb#L834
  #
  #   unknown OID 5069: failed to recognize type of 'transaction_id'. It will be treated as String.
  #
  # https://discuss.rubyonrails.org/t/global-custom-database-type-registration/84623
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.singleton_class.prepend(PgXid8::InitializeTypeMap)

  # This eliminates an error in ActiveRecord::ConnectionAdapters::PostgreSQL::SchemaDumper#table
  # https://github.com/rails/rails/blob/747a03ba7722b6f0a7ce42e86cea83cf07a2e6ef/activerecord/lib/active_record/schema_dumper.rb#L180
  #
  #   Unknown type 'xid' for column 'transaction_id'
  #
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter::NATIVE_DATABASE_TYPES[:xid8] = {name: "xid8"}

  ActiveRecord::ConnectionAdapters::TableDefinition.prepend(PgXid8::Column)
  ActiveRecord::ConnectionAdapters::Table.prepend(PgXid8::Column)

  # This doesn't appear to be necessary, unless you wanted to override a model's
  # attribute that was not a Xid8 by default.
  ActiveRecord::Type.register(:xid8, PgXid8::Type::Xid8, adapter: :postgresql)
end
