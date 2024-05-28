# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `database_cleaner-active_record` gem.
# Please instead update this file by running `bin/tapioca gem database_cleaner-active_record`.


# source://database_cleaner-active_record//lib/database_cleaner/active_record/version.rb#1
module DatabaseCleaner
  class << self
    # source://forwardable/1.3.2/forwardable.rb#229
    def [](*args, **_arg1, &block); end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#17
    def allow_production; end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#17
    def allow_production=(_arg0); end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#17
    def allow_remote_database_url; end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#17
    def allow_remote_database_url=(_arg0); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def clean(*args, **_arg1, &block); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def clean_with(*args, **_arg1, &block); end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#22
    def cleaners; end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#25
    def cleaners=(_arg0); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def cleaning(*args, **_arg1, &block); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def start(*args, **_arg1, &block); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def strategy=(*args, **_arg1, &block); end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#17
    def url_allowlist; end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#17
    def url_allowlist=(_arg0); end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#17
    def url_whitelist; end

    # source://database_cleaner-core/2.0.1/lib/database_cleaner/core.rb#17
    def url_whitelist=(_arg0); end
  end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/version.rb#2
module DatabaseCleaner::ActiveRecord
  class << self
    # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#12
    def config_file_location; end

    # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#8
    def config_file_location=(path); end
  end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#16
class DatabaseCleaner::ActiveRecord::Base < ::DatabaseCleaner::Strategy
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#39
  def connection_class; end

  # Returns the value of attribute connection_hash.
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#37
  def connection_hash; end

  # Sets the attribute connection_hash
  #
  # @param value the value to set the attribute connection_hash to.
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#37
  def connection_hash=(_arg0); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#32
  def db=(*_arg0); end

  private

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#69
  def active_record_config_hash_for(db); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#91
  def database_for(model); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#86
  def establish_connection; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#51
  def load_config; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#77
  def lookup_from_connection_pool; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#63
  def valid_config(connection_file, db); end

  class << self
    # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#25
    def exclusion_condition(column_name); end

    # source://database_cleaner-active_record//lib/database_cleaner/active_record/base.rb#17
    def migration_table_name; end
  end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#61
class DatabaseCleaner::ActiveRecord::ConnectionWrapper < ::SimpleDelegator
  # @return [ConnectionWrapper] a new instance of ConnectionWrapper
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#62
  def initialize(connection); end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#77
module DatabaseCleaner::ActiveRecord::ConnectionWrapper::AbstractAdapter
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#84
  def database_cleaner_table_cache; end

  # used to be called views but that can clash with gems like schema_plus
  # this gem is not meant to be exposing such an extra interface any way
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#80
  def database_cleaner_view_cache; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#89
  def database_tables; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#93
  def truncate_table(table_name); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#99
  def truncate_tables(tables); end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#104
module DatabaseCleaner::ActiveRecord::ConnectionWrapper::AbstractMysqlAdapter
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#109
  def pre_count_tables(tables); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#105
  def pre_count_truncate_tables(tables); end

  private

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#119
  def auto_increment_value(table); end

  # This method tells us if the given table has been inserted into since its
  # last truncation. Note that the table might have been populated, which
  # increased the auto-increment counter, but then cleaned again such that
  # it appears empty now.
  #
  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#132
  def has_been_used?(table); end

  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#136
  def has_rows?(table); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#115
  def row_count(table); end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#185
module DatabaseCleaner::ActiveRecord::ConnectionWrapper::PostgreSQLAdapter
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#203
  def database_cleaner_table_cache; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#186
  def database_tables; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#199
  def pre_count_tables(tables); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#195
  def pre_count_truncate_tables(tables); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#190
  def truncate_tables(table_names); end

  private

  # Returns a boolean indicating if the given table has an auto-inc number higher than 0.
  # Note, this is different than an empty table since an table may populated, the index increased,
  # but then the table is cleaned.  In other words, this function tells us if the given table
  # was ever inserted into.
  #
  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#218
  def has_been_used?(table); end

  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#229
  def has_rows?(table); end

  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#225
  def has_sequence?(table); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#233
  def tables_with_schema; end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#141
module DatabaseCleaner::ActiveRecord::ConnectionWrapper::SQLiteAdapter
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#157
  def pre_count_tables(tables); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#153
  def pre_count_truncate_tables(tables); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#142
  def truncate_table(table_name); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#149
  def truncate_tables(tables); end

  private

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#164
  def fetch_sequences; end

  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#170
  def has_been_used?(table, sequences); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#175
  def row_count(table); end

  # Returns a boolean indicating if the SQLite database is using the sqlite_sequence table.
  #
  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#180
  def uses_sequence?; end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/deletion.rb#6
class DatabaseCleaner::ActiveRecord::Deletion < ::DatabaseCleaner::ActiveRecord::Truncation
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/deletion.rb#7
  def clean; end

  private

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/deletion.rb#53
  def build_table_stats_query(connection); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/deletion.rb#25
  def delete_table(connection, table_name); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/deletion.rb#19
  def delete_tables(connection, table_names); end

  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/deletion.rb#66
  def information_schema_exists?(connection); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/deletion.rb#47
  def table_stats_query(connection); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/deletion.rb#29
  def tables_to_truncate(connection); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/deletion.rb#38
  def tables_with_new_rows(connection); end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/transaction.rb#5
class DatabaseCleaner::ActiveRecord::Transaction < ::DatabaseCleaner::ActiveRecord::Base
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/transaction.rb#14
  def clean; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/transaction.rb#6
  def start; end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#7
class DatabaseCleaner::ActiveRecord::Truncation < ::DatabaseCleaner::ActiveRecord::Base
  # @return [Truncation] a new instance of Truncation
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#8
  def initialize(opts = T.unsafe(nil)); end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#20
  def clean; end

  private

  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#52
  def cache_tables?; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#32
  def connection; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#45
  def migration_storage_names; end

  # @return [Boolean]
  #
  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#56
  def pre_count?; end

  # source://database_cleaner-active_record//lib/database_cleaner/active_record/truncation.rb#36
  def tables_to_truncate(connection); end
end

# source://database_cleaner-active_record//lib/database_cleaner/active_record/version.rb#3
DatabaseCleaner::ActiveRecord::VERSION = T.let(T.unsafe(nil), String)
