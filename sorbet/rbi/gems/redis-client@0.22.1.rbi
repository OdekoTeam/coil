# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `redis-client` gem.
# Please instead update this file by running `bin/tapioca gem redis-client`.


module Process
  extend ::ConnectionPool::ForkTracker
  extend ::RedisClient::PIDCache::CoreExt
  extend ::ActiveSupport::ForkTracker::CoreExt
end

# source://redis-client//lib/redis_client/version.rb#3
class RedisClient
  include ::RedisClient::Common

  # source://redis-client//lib/redis_client.rb#188
  def initialize(config, **_arg1); end

  # source://redis-client//lib/redis_client.rb#335
  def blocking_call(timeout, *command, **kwargs); end

  # source://redis-client//lib/redis_client.rb#355
  def blocking_call_v(timeout, command); end

  # source://redis-client//lib/redis_client.rb#275
  def call(*command, **kwargs); end

  # source://redis-client//lib/redis_client.rb#305
  def call_once(*command, **kwargs); end

  # source://redis-client//lib/redis_client.rb#320
  def call_once_v(command); end

  # source://redis-client//lib/redis_client.rb#290
  def call_v(command); end

  # source://redis-client//lib/redis_client.rb#415
  def close; end

  # source://redis-client//lib/redis_client.rb#411
  def connected?; end

  # source://redis-client//lib/redis_client.rb#212
  def db; end

  # source://redis-client//lib/redis_client.rb#420
  def disable_reconnection(&block); end

  # source://redis-client//lib/redis_client.rb#216
  def host; end

  # source://redis-client//lib/redis_client.rb#393
  def hscan(key, *args, **kwargs, &block); end

  # source://redis-client//lib/redis_client.rb#204
  def id; end

  # source://redis-client//lib/redis_client.rb#195
  def inspect; end

  # source://redis-client//lib/redis_client.rb#267
  def measure_round_trip_delay; end

  # source://redis-client//lib/redis_client.rb#442
  def multi(watch: T.unsafe(nil), &block); end

  # source://redis-client//lib/redis_client.rb#232
  def password; end

  # source://redis-client//lib/redis_client.rb#224
  def path; end

  # source://redis-client//lib/redis_client.rb#424
  def pipelined(exception: T.unsafe(nil)); end

  # source://redis-client//lib/redis_client.rb#220
  def port; end

  # source://redis-client//lib/redis_client.rb#261
  def pubsub; end

  # source://redis-client//lib/redis_client.rb#251
  def read_timeout=(timeout); end

  # source://redis-client//lib/redis_client.rb#375
  def scan(*args, **kwargs, &block); end

  # source://redis-client//lib/redis_client.rb#200
  def server_url; end

  # source://redis-client//lib/redis_client.rb#236
  def size; end

  # source://redis-client//lib/redis_client.rb#384
  def sscan(key, *args, **kwargs, &block); end

  # source://redis-client//lib/redis_client.rb#240
  def then(_options = T.unsafe(nil)); end

  # source://redis-client//lib/redis_client.rb#208
  def timeout; end

  # source://redis-client//lib/redis_client.rb#245
  def timeout=(timeout); end

  # source://redis-client//lib/redis_client.rb#228
  def username; end

  # source://redis-client//lib/redis_client.rb#240
  def with(_options = T.unsafe(nil)); end

  # source://redis-client//lib/redis_client.rb#256
  def write_timeout=(timeout); end

  # source://redis-client//lib/redis_client.rb#402
  def zscan(key, *args, **kwargs, &block); end

  private

  # source://redis-client//lib/redis_client.rb#649
  def build_transaction; end

  # source://redis-client//lib/redis_client.rb#737
  def connect; end

  # source://redis-client//lib/redis_client.rb#683
  def ensure_connected(retryable: T.unsafe(nil)); end

  # source://redis-client//lib/redis_client.rb#730
  def raw_connection; end

  # source://redis-client//lib/redis_client.rb#657
  def scan_list(cursor_index, command, &block); end

  # source://redis-client//lib/redis_client.rb#667
  def scan_pairs(cursor_index, command); end

  class << self
    # source://redis-client//lib/redis_client.rb#165
    def config(**kwargs); end

    # source://redis-client//lib/redis_client.rb#33
    def default_driver; end

    # source://redis-client//lib/redis_client.rb#45
    def default_driver=(name); end

    # source://redis-client//lib/redis_client.rb#22
    def driver(name); end

    # source://redis-client//lib/redis_client.rb#173
    def new(arg = T.unsafe(nil), **kwargs); end

    # source://redis-client//lib/redis_client.rb#181
    def register(middleware); end

    # source://redis-client//lib/redis_client.rb#18
    def register_driver(name, &block); end

    # source://redis-client//lib/redis_client.rb#169
    def sentinel(**kwargs); end
  end
end

# source://redis-client//lib/redis_client.rb#144
class RedisClient::AuthenticationError < ::RedisClient::CommandError; end

# source://redis-client//lib/redis_client/middlewares.rb#4
class RedisClient::BasicMiddleware
  # source://redis-client//lib/redis_client/middlewares.rb#7
  def initialize(client); end

  # source://redis-client//lib/redis_client/middlewares.rb#15
  def call(command, _config); end

  # source://redis-client//lib/redis_client/middlewares.rb#15
  def call_pipelined(command, _config); end

  # source://redis-client//lib/redis_client/middlewares.rb#5
  def client; end

  # source://redis-client//lib/redis_client/middlewares.rb#11
  def connect(_config); end
end

# source://redis-client//lib/redis_client.rb#108
class RedisClient::CannotConnectError < ::RedisClient::ConnectionError; end

# source://redis-client//lib/redis_client.rb#115
class RedisClient::CheckoutTimeoutError < ::RedisClient::TimeoutError; end

# source://redis-client//lib/redis_client/circuit_breaker.rb#4
class RedisClient::CircuitBreaker
  # source://redis-client//lib/redis_client/circuit_breaker.rb#23
  def initialize(error_threshold:, error_timeout:, error_threshold_timeout: T.unsafe(nil), success_threshold: T.unsafe(nil)); end

  # source://redis-client//lib/redis_client/circuit_breaker.rb#21
  def error_threshold; end

  # source://redis-client//lib/redis_client/circuit_breaker.rb#21
  def error_threshold_timeout; end

  # source://redis-client//lib/redis_client/circuit_breaker.rb#21
  def error_timeout; end

  # source://redis-client//lib/redis_client/circuit_breaker.rb#34
  def protect; end

  # source://redis-client//lib/redis_client/circuit_breaker.rb#21
  def success_threshold; end

  private

  # source://redis-client//lib/redis_client/circuit_breaker.rb#80
  def record_error; end

  # source://redis-client//lib/redis_client/circuit_breaker.rb#95
  def record_success; end

  # source://redis-client//lib/redis_client/circuit_breaker.rb#65
  def refresh_state; end
end

# source://redis-client//lib/redis_client/circuit_breaker.rb#5
module RedisClient::CircuitBreaker::Middleware
  # source://redis-client//lib/redis_client/circuit_breaker.rb#10
  def call(_command, config); end

  # source://redis-client//lib/redis_client/circuit_breaker.rb#14
  def call_pipelined(_commands, config); end

  # source://redis-client//lib/redis_client/circuit_breaker.rb#6
  def connect(config); end
end

# source://redis-client//lib/redis_client/circuit_breaker.rb#19
class RedisClient::CircuitBreaker::OpenCircuitError < ::RedisClient::CannotConnectError; end

# source://redis-client//lib/redis_client/command_builder.rb#4
module RedisClient::CommandBuilder
  extend ::RedisClient::CommandBuilder

  # source://redis-client//lib/redis_client/command_builder.rb#8
  def generate(args, kwargs = T.unsafe(nil)); end
end

# source://redis-client//lib/redis_client.rb#125
class RedisClient::CommandError < ::RedisClient::Error
  include ::RedisClient::HasCommand

  class << self
    # source://redis-client//lib/redis_client.rb#129
    def parse(error_message); end
  end
end

# source://redis-client//lib/redis_client.rb#155
RedisClient::CommandError::ERRORS = T.let(T.unsafe(nil), Hash)

# source://redis-client//lib/redis_client.rb#55
module RedisClient::Common
  # source://redis-client//lib/redis_client.rb#59
  def initialize(config, id: T.unsafe(nil), connect_timeout: T.unsafe(nil), read_timeout: T.unsafe(nil), write_timeout: T.unsafe(nil)); end

  # source://redis-client//lib/redis_client.rb#56
  def config; end

  # source://redis-client//lib/redis_client.rb#57
  def connect_timeout; end

  # source://redis-client//lib/redis_client.rb#57
  def connect_timeout=(_arg0); end

  # source://redis-client//lib/redis_client.rb#56
  def id; end

  # source://redis-client//lib/redis_client.rb#57
  def read_timeout; end

  # source://redis-client//lib/redis_client.rb#57
  def read_timeout=(_arg0); end

  # source://redis-client//lib/redis_client.rb#75
  def timeout=(timeout); end

  # source://redis-client//lib/redis_client.rb#57
  def write_timeout; end

  # source://redis-client//lib/redis_client.rb#57
  def write_timeout=(_arg0); end
end

# source://redis-client//lib/redis_client/config.rb#7
class RedisClient::Config
  include ::RedisClient::Config::Common

  # source://redis-client//lib/redis_client/config.rb#179
  def initialize(url: T.unsafe(nil), host: T.unsafe(nil), port: T.unsafe(nil), path: T.unsafe(nil), username: T.unsafe(nil), password: T.unsafe(nil), **kwargs); end

  # source://redis-client//lib/redis_client/config.rb#177
  def host; end

  # source://redis-client//lib/redis_client/config.rb#177
  def path; end

  # source://redis-client//lib/redis_client/config.rb#177
  def port; end
end

# source://redis-client//lib/redis_client/config.rb#14
module RedisClient::Config::Common
  # source://redis-client//lib/redis_client/config.rb#21
  def initialize(username: T.unsafe(nil), password: T.unsafe(nil), db: T.unsafe(nil), id: T.unsafe(nil), timeout: T.unsafe(nil), read_timeout: T.unsafe(nil), write_timeout: T.unsafe(nil), connect_timeout: T.unsafe(nil), ssl: T.unsafe(nil), custom: T.unsafe(nil), ssl_params: T.unsafe(nil), driver: T.unsafe(nil), protocol: T.unsafe(nil), client_implementation: T.unsafe(nil), command_builder: T.unsafe(nil), inherit_socket: T.unsafe(nil), reconnect_attempts: T.unsafe(nil), middlewares: T.unsafe(nil), circuit_breaker: T.unsafe(nil)); end

  # source://redis-client//lib/redis_client/config.rb#15
  def circuit_breaker; end

  # source://redis-client//lib/redis_client/config.rb#15
  def command_builder; end

  # source://redis-client//lib/redis_client/config.rb#15
  def connect_timeout; end

  # source://redis-client//lib/redis_client/config.rb#15
  def connection_prelude; end

  # source://redis-client//lib/redis_client/config.rb#15
  def custom; end

  # source://redis-client//lib/redis_client/config.rb#15
  def db; end

  # source://redis-client//lib/redis_client/config.rb#15
  def driver; end

  # source://redis-client//lib/redis_client/config.rb#15
  def id; end

  # source://redis-client//lib/redis_client/config.rb#15
  def inherit_socket; end

  # source://redis-client//lib/redis_client/config.rb#15
  def middlewares_stack; end

  # source://redis-client//lib/redis_client/config.rb#107
  def new_client(**kwargs); end

  # source://redis-client//lib/redis_client/config.rb#102
  def new_pool(**kwargs); end

  # source://redis-client//lib/redis_client/config.rb#15
  def password; end

  # source://redis-client//lib/redis_client/config.rb#15
  def protocol; end

  # source://redis-client//lib/redis_client/config.rb#15
  def read_timeout; end

  # source://redis-client//lib/redis_client/config.rb#94
  def resolved?; end

  # source://redis-client//lib/redis_client/config.rb#111
  def retry_connecting?(attempt, _error); end

  # source://redis-client//lib/redis_client/config.rb#98
  def sentinel?; end

  # source://redis-client//lib/redis_client/config.rb#129
  def server_url; end

  # source://redis-client//lib/redis_client/config.rb#15
  def ssl; end

  def ssl?; end

  # source://redis-client//lib/redis_client/config.rb#123
  def ssl_context; end

  # source://redis-client//lib/redis_client/config.rb#15
  def ssl_params; end

  # source://redis-client//lib/redis_client/config.rb#90
  def username; end

  # source://redis-client//lib/redis_client/config.rb#15
  def write_timeout; end

  private

  # source://redis-client//lib/redis_client/config.rb#146
  def build_connection_prelude; end
end

# source://redis-client//lib/redis_client/config.rb#12
RedisClient::Config::DEFAULT_DB = T.let(T.unsafe(nil), Integer)

# source://redis-client//lib/redis_client/config.rb#9
RedisClient::Config::DEFAULT_HOST = T.let(T.unsafe(nil), String)

# source://redis-client//lib/redis_client/config.rb#10
RedisClient::Config::DEFAULT_PORT = T.let(T.unsafe(nil), Integer)

# source://redis-client//lib/redis_client/config.rb#8
RedisClient::Config::DEFAULT_TIMEOUT = T.let(T.unsafe(nil), Float)

# source://redis-client//lib/redis_client/config.rb#11
RedisClient::Config::DEFAULT_USERNAME = T.let(T.unsafe(nil), String)

# source://redis-client//lib/redis_client.rb#107
class RedisClient::ConnectionError < ::RedisClient::Error; end

# source://redis-client//lib/redis_client/connection_mixin.rb#4
module RedisClient::ConnectionMixin
  # source://redis-client//lib/redis_client/connection_mixin.rb#5
  def initialize; end

  # source://redis-client//lib/redis_client/connection_mixin.rb#28
  def call(command, timeout); end

  # source://redis-client//lib/redis_client/connection_mixin.rb#42
  def call_pipelined(commands, timeouts, exception: T.unsafe(nil)); end

  # source://redis-client//lib/redis_client/connection_mixin.rb#14
  def close; end

  # source://redis-client//lib/redis_client/connection_mixin.rb#9
  def reconnect; end

  # source://redis-client//lib/redis_client/connection_mixin.rb#19
  def revalidate; end
end

# source://redis-client//lib/redis_client/decorator.rb#4
module RedisClient::Decorator
  class << self
    # source://redis-client//lib/redis_client/decorator.rb#6
    def create(commands_mixin); end
  end
end

# source://redis-client//lib/redis_client/decorator.rb#37
class RedisClient::Decorator::Client
  include ::RedisClient::Decorator::CommandsMixin

  # source://redis-client//lib/redis_client/decorator.rb#40
  def initialize(_client); end

  # source://redis-client//lib/redis_client/decorator.rb#60
  def close(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/decorator.rb#69
  def config; end

  # source://redis-client//lib/redis_client/decorator.rb#69
  def connect_timeout; end

  # source://redis-client//lib/redis_client/decorator.rb#77
  def connect_timeout=(value); end

  # source://redis-client//lib/redis_client/decorator.rb#60
  def hscan(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/decorator.rb#69
  def id; end

  # source://redis-client//lib/redis_client/decorator.rb#54
  def multi(**kwargs); end

  # source://redis-client//lib/redis_client/decorator.rb#50
  def pipelined(exception: T.unsafe(nil)); end

  # source://redis-client//lib/redis_client/decorator.rb#69
  def pubsub; end

  # source://redis-client//lib/redis_client/decorator.rb#69
  def read_timeout; end

  # source://redis-client//lib/redis_client/decorator.rb#77
  def read_timeout=(value); end

  # source://redis-client//lib/redis_client/decorator.rb#60
  def scan(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/decorator.rb#69
  def size; end

  # source://redis-client//lib/redis_client/decorator.rb#60
  def sscan(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/decorator.rb#77
  def timeout=(value); end

  # source://redis-client//lib/redis_client/decorator.rb#45
  def with(*args, **_arg1); end

  # source://redis-client//lib/redis_client/decorator.rb#69
  def write_timeout; end

  # source://redis-client//lib/redis_client/decorator.rb#77
  def write_timeout=(value); end

  # source://redis-client//lib/redis_client/decorator.rb#60
  def zscan(*args, **_arg1, &block); end
end

# source://redis-client//lib/redis_client/decorator.rb#18
module RedisClient::Decorator::CommandsMixin
  # source://redis-client//lib/redis_client/decorator.rb#19
  def initialize(client); end

  # source://redis-client//lib/redis_client/decorator.rb#25
  def blocking_call(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/decorator.rb#25
  def blocking_call_v(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/decorator.rb#25
  def call(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/decorator.rb#25
  def call_once(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/decorator.rb#25
  def call_once_v(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/decorator.rb#25
  def call_v(*args, **_arg1, &block); end
end

# source://redis-client//lib/redis_client/decorator.rb#33
class RedisClient::Decorator::Pipeline
  include ::RedisClient::Decorator::CommandsMixin
end

# source://redis-client//lib/redis_client.rb#94
class RedisClient::Error < ::StandardError
  include ::RedisClient::HasConfig

  class << self
    # source://redis-client//lib/redis_client.rb#97
    def with_config(message, config = T.unsafe(nil)); end
  end
end

# source://redis-client//lib/redis_client.rb#110
class RedisClient::FailoverError < ::RedisClient::ConnectionError; end

# source://redis-client//lib/redis_client.rb#117
module RedisClient::HasCommand
  # source://redis-client//lib/redis_client.rb#120
  def _set_command(command); end

  # source://redis-client//lib/redis_client.rb#118
  def command; end
end

# source://redis-client//lib/redis_client.rb#80
module RedisClient::HasConfig
  # source://redis-client//lib/redis_client.rb#83
  def _set_config(config); end

  # source://redis-client//lib/redis_client.rb#81
  def config; end

  # source://redis-client//lib/redis_client.rb#87
  def message; end
end

# source://redis-client//lib/redis_client.rb#152
class RedisClient::MasterDownError < ::RedisClient::ConnectionError
  include ::RedisClient::HasCommand
end

# source://redis-client//lib/redis_client/middlewares.rb#21
class RedisClient::Middlewares < ::RedisClient::BasicMiddleware; end

# source://redis-client//lib/redis_client.rb#523
class RedisClient::Multi
  # source://redis-client//lib/redis_client.rb#524
  def initialize(command_builder); end

  # source://redis-client//lib/redis_client.rb#566
  def _blocks; end

  # source://redis-client//lib/redis_client.rb#586
  def _coerce!(results); end

  # source://redis-client//lib/redis_client.rb#562
  def _commands; end

  # source://redis-client//lib/redis_client.rb#574
  def _empty?; end

  # source://redis-client//lib/redis_client.rb#582
  def _retryable?; end

  # source://redis-client//lib/redis_client.rb#570
  def _size; end

  # source://redis-client//lib/redis_client.rb#578
  def _timeouts; end

  # source://redis-client//lib/redis_client.rb#532
  def call(*command, **kwargs, &block); end

  # source://redis-client//lib/redis_client.rb#546
  def call_once(*command, **kwargs, &block); end

  # source://redis-client//lib/redis_client.rb#554
  def call_once_v(command, &block); end

  # source://redis-client//lib/redis_client.rb#539
  def call_v(command, &block); end
end

# source://redis-client//lib/redis_client.rb#147
class RedisClient::OutOfMemoryError < ::RedisClient::CommandError; end

# source://redis-client//lib/redis_client/pid_cache.rb#4
module RedisClient::PIDCache
  class << self
    # source://redis-client//lib/redis_client/pid_cache.rb#10
    def pid; end

    # source://redis-client//lib/redis_client/pid_cache.rb#12
    def update!; end
  end
end

# source://redis-client//lib/redis_client/pid_cache.rb#18
module RedisClient::PIDCache::CoreExt
  # source://redis-client//lib/redis_client/pid_cache.rb#19
  def _fork; end
end

# source://redis-client//lib/redis_client.rb#145
class RedisClient::PermissionError < ::RedisClient::CommandError; end

# source://redis-client//lib/redis_client.rb#602
class RedisClient::Pipeline < ::RedisClient::Multi
  # source://redis-client//lib/redis_client.rb#603
  def initialize(_command_builder); end

  # source://redis-client//lib/redis_client.rb#634
  def _coerce!(results); end

  # source://redis-client//lib/redis_client.rb#630
  def _empty?; end

  # source://redis-client//lib/redis_client.rb#626
  def _timeouts; end

  # source://redis-client//lib/redis_client.rb#608
  def blocking_call(timeout, *command, **kwargs, &block); end

  # source://redis-client//lib/redis_client.rb#617
  def blocking_call_v(timeout, command, &block); end
end

# source://redis-client//lib/redis_client/pooled.rb#6
class RedisClient::Pooled
  include ::RedisClient::Common

  # source://redis-client//lib/redis_client/pooled.rb#11
  def initialize(config, id: T.unsafe(nil), connect_timeout: T.unsafe(nil), read_timeout: T.unsafe(nil), write_timeout: T.unsafe(nil), **kwargs); end

  # source://redis-client//lib/redis_client/pooled.rb#56
  def blocking_call(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#56
  def blocking_call_v(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#56
  def call(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#56
  def call_once(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#56
  def call_once_v(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#56
  def call_v(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#37
  def close; end

  # source://redis-client//lib/redis_client/pooled.rb#65
  def hscan(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#56
  def multi(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#56
  def pipelined(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#56
  def pubsub(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#65
  def scan(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#48
  def size; end

  # source://redis-client//lib/redis_client/pooled.rb#65
  def sscan(*args, **_arg1, &block); end

  # source://redis-client//lib/redis_client/pooled.rb#25
  def then(options = T.unsafe(nil)); end

  # source://redis-client//lib/redis_client/pooled.rb#25
  def with(options = T.unsafe(nil)); end

  # source://redis-client//lib/redis_client/pooled.rb#65
  def zscan(*args, **_arg1, &block); end

  private

  # source://redis-client//lib/redis_client/pooled.rb#82
  def new_pool; end

  # source://redis-client//lib/redis_client/pooled.rb#78
  def pool; end
end

# source://redis-client//lib/redis_client/pooled.rb#7
RedisClient::Pooled::EMPTY_HASH = T.let(T.unsafe(nil), Hash)

# source://redis-client//lib/redis_client.rb#104
class RedisClient::ProtocolError < ::RedisClient::Error; end

# source://redis-client//lib/redis_client.rb#486
class RedisClient::PubSub
  # source://redis-client//lib/redis_client.rb#487
  def initialize(raw_connection, command_builder); end

  # source://redis-client//lib/redis_client.rb#492
  def call(*command, **kwargs); end

  # source://redis-client//lib/redis_client.rb#497
  def call_v(command); end

  # source://redis-client//lib/redis_client.rb#502
  def close; end

  # source://redis-client//lib/redis_client.rb#508
  def next_event(timeout = T.unsafe(nil)); end

  private

  # source://redis-client//lib/redis_client.rb#520
  def raw_connection; end
end

# source://redis-client//lib/redis_client/ruby_connection/resp3.rb#4
module RedisClient::RESP3
  private

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#36
  def dump(command, buffer = T.unsafe(nil)); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#57
  def dump_any(object, buffer); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#68
  def dump_array(array, buffer); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#84
  def dump_hash(hash, buffer); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#93
  def dump_numeric(numeric, buffer); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#76
  def dump_set(set, buffer); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#97
  def dump_string(string, buffer); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#103
  def dump_symbol(symbol, buffer); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#49
  def load(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#53
  def new_buffer; end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#112
  def parse(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#166
  def parse_array(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#218
  def parse_blob(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#155
  def parse_boolean(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#200
  def parse_double(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#151
  def parse_error(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#196
  def parse_integer(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#174
  def parse_map(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#213
  def parse_null(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#182
  def parse_push(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#186
  def parse_sequence(io, size); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#170
  def parse_set(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#145
  def parse_string(io); end

  # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#227
  def parse_verbatim_string(io); end

  class << self
    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#36
    def dump(command, buffer = T.unsafe(nil)); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#57
    def dump_any(object, buffer); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#68
    def dump_array(array, buffer); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#84
    def dump_hash(hash, buffer); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#93
    def dump_numeric(numeric, buffer); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#76
    def dump_set(set, buffer); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#97
    def dump_string(string, buffer); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#103
    def dump_symbol(symbol, buffer); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#49
    def load(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#53
    def new_buffer; end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#112
    def parse(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#166
    def parse_array(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#218
    def parse_blob(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#155
    def parse_boolean(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#200
    def parse_double(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#151
    def parse_error(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#196
    def parse_integer(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#174
    def parse_map(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#213
    def parse_null(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#182
    def parse_push(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#186
    def parse_sequence(io, size); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#170
    def parse_set(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#145
    def parse_string(io); end

    # source://redis-client//lib/redis_client/ruby_connection/resp3.rb#227
    def parse_verbatim_string(io); end
  end
end

# source://redis-client//lib/redis_client/ruby_connection/resp3.rb#13
RedisClient::RESP3::DUMP_TYPES = T.let(T.unsafe(nil), Hash)

# source://redis-client//lib/redis_client/ruby_connection/resp3.rb#11
RedisClient::RESP3::EOL = T.let(T.unsafe(nil), String)

# source://redis-client//lib/redis_client/ruby_connection/resp3.rb#12
RedisClient::RESP3::EOL_SIZE = T.let(T.unsafe(nil), Integer)

# source://redis-client//lib/redis_client/ruby_connection/resp3.rb#7
class RedisClient::RESP3::Error < ::RedisClient::Error; end

# source://redis-client//lib/redis_client/ruby_connection/resp3.rb#34
RedisClient::RESP3::INTEGER_RANGE = T.let(T.unsafe(nil), Range)

# source://redis-client//lib/redis_client/ruby_connection/resp3.rb#19
RedisClient::RESP3::PARSER_TYPES = T.let(T.unsafe(nil), Hash)

# source://redis-client//lib/redis_client/ruby_connection/resp3.rb#9
class RedisClient::RESP3::SyntaxError < ::RedisClient::RESP3::Error; end

# source://redis-client//lib/redis_client/ruby_connection/resp3.rb#8
class RedisClient::RESP3::UnknownType < ::RedisClient::RESP3::Error; end

# source://redis-client//lib/redis_client.rb#149
class RedisClient::ReadOnlyError < ::RedisClient::ConnectionError
  include ::RedisClient::HasCommand
end

# source://redis-client//lib/redis_client.rb#113
class RedisClient::ReadTimeoutError < ::RedisClient::TimeoutError; end

# source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#6
class RedisClient::RubyConnection
  include ::RedisClient::ConnectionMixin

  # source://redis-client//lib/redis_client/ruby_connection.rb#45
  def initialize(config, connect_timeout:, read_timeout:, write_timeout:); end

  # source://redis-client//lib/redis_client/ruby_connection.rb#58
  def close; end

  # source://redis-client//lib/redis_client/ruby_connection.rb#43
  def config; end

  # source://redis-client//lib/redis_client/ruby_connection.rb#54
  def connected?; end

  # source://redis-client//lib/redis_client/ruby_connection.rb#106
  def measure_round_trip_delay; end

  # source://redis-client//lib/redis_client/ruby_connection.rb#94
  def read(timeout = T.unsafe(nil)); end

  # source://redis-client//lib/redis_client/ruby_connection.rb#63
  def read_timeout=(timeout); end

  # source://redis-client//lib/redis_client/ruby_connection.rb#73
  def write(command); end

  # source://redis-client//lib/redis_client/ruby_connection.rb#82
  def write_multi(commands); end

  # source://redis-client//lib/redis_client/ruby_connection.rb#68
  def write_timeout=(timeout); end

  private

  # source://redis-client//lib/redis_client/ruby_connection.rb#114
  def connect; end

  # source://redis-client//lib/redis_client/ruby_connection.rb#165
  def enable_socket_keep_alive(socket); end

  class << self
    # source://redis-client//lib/redis_client/ruby_connection.rb#14
    def ssl_context(ssl_params); end
  end
end

# source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#7
class RedisClient::RubyConnection::BufferedIO
  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#16
  def initialize(io, read_timeout:, write_timeout:, chunk_size: T.unsafe(nil)); end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#89
  def close; end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#93
  def closed?; end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#97
  def eof?; end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#150
  def getbyte; end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#26
  def gets_chomp; end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#159
  def gets_integer; end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#37
  def read_chomp(bytes); end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#11
  def read_timeout; end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#11
  def read_timeout=(_arg0); end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#121
  def skip(offset); end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#101
  def with_timeout(new_timeout); end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#127
  def write(string); end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#11
  def write_timeout; end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#11
  def write_timeout=(_arg0); end

  private

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#44
  def ensure_line; end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#184
  def ensure_remaining(bytes); end

  # source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#191
  def fill_buffer(strict, size = T.unsafe(nil)); end
end

# source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#14
RedisClient::RubyConnection::BufferedIO::ENCODING = T.let(T.unsafe(nil), Encoding)

# source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#8
RedisClient::RubyConnection::BufferedIO::EOL = T.let(T.unsafe(nil), String)

# source://redis-client//lib/redis_client/ruby_connection/buffered_io.rb#9
RedisClient::RubyConnection::BufferedIO::EOL_SIZE = T.let(T.unsafe(nil), Integer)

# source://redis-client//lib/redis_client/ruby_connection.rb#157
RedisClient::RubyConnection::KEEP_ALIVE_INTERVAL = T.let(T.unsafe(nil), Integer)

# source://redis-client//lib/redis_client/ruby_connection.rb#159
RedisClient::RubyConnection::KEEP_ALIVE_PROBES = T.let(T.unsafe(nil), Integer)

# source://redis-client//lib/redis_client/ruby_connection.rb#158
RedisClient::RubyConnection::KEEP_ALIVE_TTL = T.let(T.unsafe(nil), Integer)

# source://redis-client//lib/redis_client/ruby_connection.rb#41
RedisClient::RubyConnection::SUPPORTS_RESOLV_TIMEOUT = T.let(T.unsafe(nil), TrueClass)

# source://redis-client//lib/redis_client/sentinel_config.rb#4
class RedisClient::SentinelConfig
  include ::RedisClient::Config::Common

  # source://redis-client//lib/redis_client/sentinel_config.rb#12
  def initialize(sentinels:, sentinel_password: T.unsafe(nil), sentinel_username: T.unsafe(nil), role: T.unsafe(nil), name: T.unsafe(nil), url: T.unsafe(nil), **client_config); end

  # source://redis-client//lib/redis_client/sentinel_config.rb#101
  def check_role!(role); end

  # source://redis-client//lib/redis_client/sentinel_config.rb#80
  def host; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#10
  def name; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#88
  def path; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#84
  def port; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#74
  def reset; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#115
  def resolved?; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#92
  def retry_connecting?(attempt, error); end

  # source://redis-client//lib/redis_client/sentinel_config.rb#97
  def sentinel?; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#68
  def sentinels; end

  private

  # source://redis-client//lib/redis_client/sentinel_config.rb#134
  def config; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#181
  def each_sentinel; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#207
  def refresh_sentinels(sentinel_client); end

  # source://redis-client//lib/redis_client/sentinel_config.rb#144
  def resolve_master; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#163
  def resolve_replica; end

  # source://redis-client//lib/redis_client/sentinel_config.rb#159
  def sentinel_client(sentinel_config); end

  # source://redis-client//lib/redis_client/sentinel_config.rb#123
  def sentinels_to_configs(sentinels); end
end

# source://redis-client//lib/redis_client/sentinel_config.rb#8
RedisClient::SentinelConfig::DEFAULT_RECONNECT_ATTEMPTS = T.let(T.unsafe(nil), Integer)

# source://redis-client//lib/redis_client/sentinel_config.rb#7
RedisClient::SentinelConfig::SENTINEL_DELAY = T.let(T.unsafe(nil), Float)

# source://redis-client//lib/redis_client.rb#112
class RedisClient::TimeoutError < ::RedisClient::ConnectionError; end

# source://redis-client//lib/redis_client/url_config.rb#6
class RedisClient::URLConfig
  # source://redis-client//lib/redis_client/url_config.rb#9
  def initialize(url); end

  # source://redis-client//lib/redis_client/url_config.rb#30
  def db; end

  # source://redis-client//lib/redis_client/url_config.rb#56
  def host; end

  # source://redis-client//lib/redis_client/url_config.rb#48
  def password; end

  # source://redis-client//lib/redis_client/url_config.rb#62
  def path; end

  # source://redis-client//lib/redis_client/url_config.rb#68
  def port; end

  # source://redis-client//lib/redis_client/url_config.rb#26
  def ssl?; end

  # source://redis-client//lib/redis_client/url_config.rb#7
  def uri; end

  # source://redis-client//lib/redis_client/url_config.rb#7
  def url; end

  # source://redis-client//lib/redis_client/url_config.rb#44
  def username; end
end

# source://redis-client//lib/redis_client.rb#105
class RedisClient::UnsupportedServer < ::RedisClient::Error; end

# source://redis-client//lib/redis_client/version.rb#4
RedisClient::VERSION = T.let(T.unsafe(nil), String)

# source://redis-client//lib/redis_client.rb#114
class RedisClient::WriteTimeoutError < ::RedisClient::TimeoutError; end

# source://redis-client//lib/redis_client.rb#146
class RedisClient::WrongTypeError < ::RedisClient::CommandError; end
