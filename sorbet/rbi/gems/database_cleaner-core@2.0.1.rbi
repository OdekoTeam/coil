# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `database_cleaner-core` gem.
# Please instead update this file by running `bin/tapioca gem database_cleaner-core`.


# Abstract strategy class for orm adapter gems to subclass
#
# source://database_cleaner-core//lib/database_cleaner/version.rb#1
module DatabaseCleaner
  class << self
    # source://forwardable/1.3.2/forwardable.rb#229
    def [](*args, **_arg1, &block); end

    # Returns the value of attribute allow_production.
    #
    # source://database_cleaner-core//lib/database_cleaner/core.rb#17
    def allow_production; end

    # Sets the attribute allow_production
    #
    # @param value the value to set the attribute allow_production to.
    #
    # source://database_cleaner-core//lib/database_cleaner/core.rb#17
    def allow_production=(_arg0); end

    # Returns the value of attribute allow_remote_database_url.
    #
    # source://database_cleaner-core//lib/database_cleaner/core.rb#17
    def allow_remote_database_url; end

    # Sets the attribute allow_remote_database_url
    #
    # @param value the value to set the attribute allow_remote_database_url to.
    #
    # source://database_cleaner-core//lib/database_cleaner/core.rb#17
    def allow_remote_database_url=(_arg0); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def clean(*args, **_arg1, &block); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def clean_with(*args, **_arg1, &block); end

    # source://database_cleaner-core//lib/database_cleaner/core.rb#22
    def cleaners; end

    # Sets the attribute cleaners
    #
    # @param value the value to set the attribute cleaners to.
    #
    # source://database_cleaner-core//lib/database_cleaner/core.rb#25
    def cleaners=(_arg0); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def cleaning(*args, **_arg1, &block); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def start(*args, **_arg1, &block); end

    # source://forwardable/1.3.2/forwardable.rb#229
    def strategy=(*args, **_arg1, &block); end

    # Returns the value of attribute url_allowlist.
    #
    # source://database_cleaner-core//lib/database_cleaner/core.rb#17
    def url_allowlist; end

    # Sets the attribute url_allowlist
    #
    # @param value the value to set the attribute url_allowlist to.
    #
    # source://database_cleaner-core//lib/database_cleaner/core.rb#17
    def url_allowlist=(_arg0); end

    # Returns the value of attribute url_allowlist.
    #
    # source://database_cleaner-core//lib/database_cleaner/core.rb#17
    def url_whitelist; end

    # Sets the attribute url_allowlist
    #
    # @param value the value to set the attribute url_allowlist to.
    #
    # source://database_cleaner-core//lib/database_cleaner/core.rb#17
    def url_whitelist=(_arg0); end
  end
end

# source://database_cleaner-core//lib/database_cleaner/cleaner.rb#8
class DatabaseCleaner::Cleaner
  include ::Comparable
  extend ::Forwardable

  # @return [Cleaner] a new instance of Cleaner
  #
  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#27
  def initialize(orm, db: T.unsafe(nil)); end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#23
  def <=>(other); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def clean(*args, **_arg1, &block); end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#62
  def clean_with(*args); end

  # source://forwardable/1.3.2/forwardable.rb#229
  def cleaning(*args, **_arg1, &block); end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#38
  def db; end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#34
  def db=(desired_db); end

  # Returns the value of attribute orm.
  #
  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#32
  def orm; end

  # source://forwardable/1.3.2/forwardable.rb#229
  def start(*args, **_arg1, &block); end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#55
  def strategy; end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#42
  def strategy=(args); end

  private

  # copied from ActiveSupport to avoid adding it as a dependency
  #
  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#103
  def camelize(term); end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#83
  def create_strategy(*args); end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#96
  def orm_module; end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#88
  def orm_strategy(strategy); end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#75
  def set_strategy_db(strategy, desired_db); end

  # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#71
  def strategy_db=(desired_db); end

  class << self
    # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#9
    def available_strategies(orm_module); end

    private

    # source://database_cleaner-core//lib/database_cleaner/cleaner.rb#111
    def underscore(camel_cased_word); end
  end
end

# source://database_cleaner-core//lib/database_cleaner/cleaners.rb#5
class DatabaseCleaner::Cleaners < ::Hash
  # @return [Cleaners] a new instance of Cleaners
  #
  # source://database_cleaner-core//lib/database_cleaner/cleaners.rb#6
  def initialize(hash = T.unsafe(nil)); end

  # FIXME this method conflates creation with lookup... both a command and a query. yuck.
  #
  # @raise [ArgumentError]
  #
  # source://database_cleaner-core//lib/database_cleaner/cleaners.rb#11
  def [](orm, **opts); end

  # source://database_cleaner-core//lib/database_cleaner/cleaners.rb#26
  def clean; end

  # source://database_cleaner-core//lib/database_cleaner/cleaners.rb#38
  def clean_with(*args); end

  # source://database_cleaner-core//lib/database_cleaner/cleaners.rb#31
  def cleaning(&inner_block); end

  # source://database_cleaner-core//lib/database_cleaner/cleaners.rb#21
  def start; end

  # source://database_cleaner-core//lib/database_cleaner/cleaners.rb#16
  def strategy=(strategy); end

  private

  # source://database_cleaner-core//lib/database_cleaner/cleaners.rb#45
  def add_cleaner(orm, **opts); end

  # source://database_cleaner-core//lib/database_cleaner/cleaners.rb#49
  def remove_duplicates; end
end

# source://database_cleaner-core//lib/database_cleaner/null_strategy.rb#2
class DatabaseCleaner::NullStrategy
  # source://database_cleaner-core//lib/database_cleaner/null_strategy.rb#11
  def clean; end

  # source://database_cleaner-core//lib/database_cleaner/null_strategy.rb#15
  def cleaning(&block); end

  # source://database_cleaner-core//lib/database_cleaner/null_strategy.rb#7
  def db=(db); end

  # source://database_cleaner-core//lib/database_cleaner/null_strategy.rb#3
  def start; end
end

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#2
class DatabaseCleaner::Safeguard
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#103
  def run; end
end

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#23
class DatabaseCleaner::Safeguard::AllowedUrl
  # @raise [Error::UrlNotAllowed]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#24
  def run; end

  private

  # @return [Boolean]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#31
  def database_url_not_allowed?; end

  # @return [Boolean]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#35
  def skip?; end
end

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#97
DatabaseCleaner::Safeguard::CHECKS = T.let(T.unsafe(nil), Array)

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#3
class DatabaseCleaner::Safeguard::Error < ::Exception; end

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#10
class DatabaseCleaner::Safeguard::Error::ProductionEnv < ::DatabaseCleaner::Safeguard::Error
  # @return [ProductionEnv] a new instance of ProductionEnv
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#11
  def initialize(env); end
end

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#4
class DatabaseCleaner::Safeguard::Error::RemoteDatabaseUrl < ::DatabaseCleaner::Safeguard::Error
  # @return [RemoteDatabaseUrl] a new instance of RemoteDatabaseUrl
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#5
  def initialize; end
end

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#16
class DatabaseCleaner::Safeguard::Error::UrlNotAllowed < ::DatabaseCleaner::Safeguard::Error
  # @return [UrlNotAllowed] a new instance of UrlNotAllowed
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#17
  def initialize; end
end

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#74
class DatabaseCleaner::Safeguard::Production
  # @raise [Error::ProductionEnv]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#77
  def run; end

  private

  # @return [Boolean]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#83
  def given?; end

  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#87
  def key; end

  # @return [Boolean]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#91
  def skip?; end
end

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#75
DatabaseCleaner::Safeguard::Production::KEYS = T.let(T.unsafe(nil), Array)

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#41
class DatabaseCleaner::Safeguard::RemoteDatabaseUrl
  # @raise [Error::RemoteDatabaseUrl]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#44
  def run; end

  private

  # @return [Boolean]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#50
  def given?; end

  # @return [Boolean]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#54
  def remote?(url); end

  # @return [Boolean]
  #
  # source://database_cleaner-core//lib/database_cleaner/safeguard.rb#67
  def skip?; end
end

# source://database_cleaner-core//lib/database_cleaner/safeguard.rb#42
DatabaseCleaner::Safeguard::RemoteDatabaseUrl::LOCAL = T.let(T.unsafe(nil), Array)

# source://database_cleaner-core//lib/database_cleaner/strategy.rb#4
class DatabaseCleaner::Strategy
  # Override this method if the strategy accepts options
  #
  # @return [Strategy] a new instance of Strategy
  #
  # source://database_cleaner-core//lib/database_cleaner/strategy.rb#6
  def initialize(options = T.unsafe(nil)); end

  # Override this method with the actual cleaning procedure. Its the only mandatory method implementation.
  #
  # @raise [NotImplementedError]
  #
  # source://database_cleaner-core//lib/database_cleaner/strategy.rb#23
  def clean; end

  # source://database_cleaner-core//lib/database_cleaner/strategy.rb#27
  def cleaning(&block); end

  # source://database_cleaner-core//lib/database_cleaner/strategy.rb#13
  def db; end

  # Sets the attribute db
  #
  # @param value the value to set the attribute db to.
  #
  # source://database_cleaner-core//lib/database_cleaner/strategy.rb#16
  def db=(_arg0); end

  # Override this method to start a database transaction if the strategy uses them
  #
  # source://database_cleaner-core//lib/database_cleaner/strategy.rb#19
  def start; end
end

# source://database_cleaner-core//lib/database_cleaner/cleaner.rb#6
class DatabaseCleaner::UnknownStrategySpecified < ::ArgumentError; end

# source://database_cleaner-core//lib/database_cleaner/version.rb#2
DatabaseCleaner::VERSION = T.let(T.unsafe(nil), String)
