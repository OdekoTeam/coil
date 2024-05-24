# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rackup` gem.
# Please instead update this file by running `bin/tapioca gem rackup`.


# source://rackup//lib/rack/handler.rb#8
module Rack
  class << self
    # source://rack/3.0.11/lib/rack/version.rb#31
    def release; end

    # source://rack/3.0.11/lib/rack/version.rb#23
    def version; end
  end
end

# source://rackup//lib/rack/handler.rb#9
Rack::Handler = Rackup::Handler

# source://rackup//lib/rack/server.rb#9
Rack::Server = Rackup::Server

# source://rackup//lib/rackup/handler.rb#6
module Rackup; end

# *Handlers* connect web servers with Rack.
#
# Rackup includes Handlers for WEBrick and CGI.
#
# Handlers usually are activated by calling <tt>MyHandler.run(myapp)</tt>.
# A second optional hash can be passed to include server-specific
# configuration.
#
# source://rackup//lib/rackup/handler.rb#14
module Rackup::Handler
  class << self
    # source://rackup//lib/rackup/handler.rb#30
    def [](name); end

    # source://rackup//lib/rackup/handler.rb#84
    def default; end

    # source://rackup//lib/rackup/handler.rb#40
    def get(name); end

    # Select first available Rack handler given an `Array` of server names.
    # Raises `LoadError` if no handler was found.
    #
    #   > pick ['puma', 'webrick']
    #   => Rackup::Handler::WEBrick
    #
    # @raise [LoadError]
    #
    # source://rackup//lib/rackup/handler.rb#69
    def pick(server_names); end

    # Register a named handler class.
    #
    # source://rackup//lib/rackup/handler.rb#18
    def register(name, klass); end

    # Transforms server-name constants to their canonical form as filenames,
    # then tries to require them but silences the LoadError if not found
    #
    # Naming convention:
    #
    #   Foo # => 'foo'
    #   FooBar # => 'foo_bar.rb'
    #   FooBAR # => 'foobar.rb'
    #   FOObar # => 'foobar.rb'
    #   FOOBAR # => 'foobar.rb'
    #   FooBarBaz # => 'foo_bar_baz.rb'
    #
    # source://rackup//lib/rackup/handler.rb#106
    def require_handler(prefix, const_name); end
  end
end

# source://rackup//lib/rackup/handler/cgi.rb#8
class Rackup::Handler::CGI
  include ::Rack

  class << self
    # source://rackup//lib/rackup/handler/cgi.rb#11
    def run(app, **options); end

    # source://rackup//lib/rackup/handler/cgi.rb#51
    def send_body(body); end

    # source://rackup//lib/rackup/handler/cgi.rb#40
    def send_headers(status, headers); end

    # source://rackup//lib/rackup/handler/cgi.rb#16
    def serve(app); end
  end
end

# source://rackup//lib/rackup/handler.rb#59
Rackup::Handler::RACKUP_HANDLER = T.let(T.unsafe(nil), String)

# source://rackup//lib/rackup/handler.rb#58
Rackup::Handler::RACK_HANDLER = T.let(T.unsafe(nil), String)

# source://rackup//lib/rackup/handler.rb#61
Rackup::Handler::SERVER_NAMES = T.let(T.unsafe(nil), Array)

# source://rackup//lib/rackup/handler/webrick.rb#18
class Rackup::Handler::WEBrick < ::WEBrick::HTTPServlet::AbstractServlet
  # @return [WEBrick] a new instance of WEBrick
  #
  # source://rackup//lib/rackup/handler/webrick.rb#54
  def initialize(server, app); end

  # source://rackup//lib/rackup/handler/webrick.rb#91
  def service(req, res); end

  class << self
    # @yield [@server]
    #
    # source://rackup//lib/rackup/handler/webrick.rb#19
    def run(app, **options); end

    # source://rackup//lib/rackup/handler/webrick.rb#47
    def shutdown; end

    # source://rackup//lib/rackup/handler/webrick.rb#37
    def valid_options; end
  end
end

# This handles mapping the WEBrick request to a Rack input stream.
#
# source://rackup//lib/rackup/handler/webrick.rb#60
class Rackup::Handler::WEBrick::Input
  include ::Rackup::Stream::Reader

  # @return [Input] a new instance of Input
  #
  # source://rackup//lib/rackup/handler/webrick.rb#63
  def initialize(request); end

  # source://rackup//lib/rackup/handler/webrick.rb#78
  def close; end

  private

  # Read one chunk from the request body.
  #
  # source://rackup//lib/rackup/handler/webrick.rb#86
  def read_next; end
end

# source://rackup//lib/rackup/server.rb#22
class Rackup::Server
  # Options may include:
  # * :app
  #     a rack application to run (overrides :config and :builder)
  # * :builder
  #     a string to evaluate a Rack::Builder from
  # * :config
  #     a rackup configuration file path to load (.ru)
  # * :environment
  #     this selects the middleware that will be wrapped around
  #     your application. Default options available are:
  #       - development: CommonLogger, ShowExceptions, and Lint
  #       - deployment: CommonLogger
  #       - none: no extra middleware
  #     note: when the server is a cgi server, CommonLogger is not included.
  # * :server
  #     choose a specific Rackup::Handler, e.g. cgi, fcgi, webrick
  # * :daemonize
  #     if truthy, the server will daemonize itself (fork, detach, etc)
  #     if :noclose, the server will not close STDOUT/STDERR
  # * :pid
  #     path to write a pid file after daemonize
  # * :Host
  #     the host address to bind to (used by supporting Rackup::Handler)
  # * :Port
  #     the port to bind to (used by supporting Rackup::Handler)
  # * :AccessLog
  #     webrick access log options (or supporting Rackup::Handler)
  # * :debug
  #     turn on debug output ($DEBUG = true)
  # * :warn
  #     turn on warnings ($-w = true)
  # * :include
  #     add given paths to $LOAD_PATH
  # * :require
  #     require the given libraries
  #
  # Additional options for profiling app initialization include:
  # * :heapfile
  #     location for ObjectSpace.dump_all to write the output to
  # * :profile_file
  #     location for CPU/Memory (StackProf) profile output (defaults to a tempfile)
  # * :profile_mode
  #     StackProf profile mode (cpu|wall|object)
  #
  # @return [Server] a new instance of Server
  #
  # source://rackup//lib/rackup/server.rb#230
  def initialize(options = T.unsafe(nil)); end

  # source://rackup//lib/rackup/server.rb#262
  def app; end

  # source://rackup//lib/rackup/server.rb#248
  def default_options; end

  # source://rackup//lib/rackup/server.rb#296
  def middleware; end

  # source://rackup//lib/rackup/server.rb#243
  def options; end

  # Sets the attribute options
  #
  # @param value the value to set the attribute options to.
  #
  # source://rackup//lib/rackup/server.rb#185
  def options=(_arg0); end

  # source://rackup//lib/rackup/server.rb#344
  def server; end

  # source://rackup//lib/rackup/server.rb#300
  def start(&block); end

  private

  # source://rackup//lib/rackup/server.rb#413
  def build_app(app); end

  # source://rackup//lib/rackup/server.rb#349
  def build_app_and_options_from_config; end

  # source://rackup//lib/rackup/server.rb#395
  def build_app_from_string; end

  # source://rackup//lib/rackup/server.rb#442
  def check_pid!; end

  # source://rackup//lib/rackup/server.rb#427
  def daemonize_app; end

  # source://rackup//lib/rackup/server.rb#456
  def exit_with_pid(pid); end

  # source://rackup//lib/rackup/server.rb#357
  def handle_profiling(heapfile, profile_mode, filename); end

  # source://rackup//lib/rackup/server.rb#385
  def make_profile_name(filename); end

  # source://rackup//lib/rackup/server.rb#409
  def opt_parser; end

  # source://rackup//lib/rackup/server.rb#399
  def parse_options(args); end

  # source://rackup//lib/rackup/server.rb#423
  def wrapped_app; end

  # source://rackup//lib/rackup/server.rb#434
  def write_pid; end

  class << self
    # source://rackup//lib/rackup/server.rb#273
    def default_middleware_by_environment; end

    # source://rackup//lib/rackup/server.rb#267
    def logging_middleware; end

    # source://rackup//lib/rackup/server.rb#291
    def middleware; end

    # Start a new rack server (like running rackup). This will parse ARGV and
    # provide standard ARGV rackup options, defaulting to load 'config.ru'.
    #
    # Providing an options hash will prevent ARGV parsing and will not include
    # any default options.
    #
    # This method can be used to very easily launch a CGI application, for
    # example:
    #
    #  Rack::Server.start(
    #    :app => lambda do |e|
    #      [200, {'content-type' => 'text/html'}, ['hello world']]
    #    end,
    #    :server => 'cgi'
    #  )
    #
    # Further options available here are documented on Rack::Server#initialize
    #
    # source://rackup//lib/rackup/server.rb#181
    def start(options = T.unsafe(nil)); end
  end
end

# source://rackup//lib/rackup/server.rb#23
class Rackup::Server::Options
  # source://rackup//lib/rackup/server.rb#143
  def handler_opts(options); end

  # source://rackup//lib/rackup/server.rb#24
  def parse!(args); end
end

# The input stream is an IO-like object which contains the raw HTTP POST data. When applicable, its external encoding must be “ASCII-8BIT” and it must be opened in binary mode, for Ruby 1.9 compatibility. The input stream must respond to gets, each, read and rewind.
#
# source://rackup//lib/rackup/stream.rb#8
class Rackup::Stream
  include ::Rackup::Stream::Reader

  # @raise [ArgumentError]
  # @return [Stream] a new instance of Stream
  #
  # source://rackup//lib/rackup/stream.rb#9
  def initialize(input = T.unsafe(nil), output = T.unsafe(nil)); end

  # source://rackup//lib/rackup/stream.rb#147
  def <<(buffer); end

  # Close the input and output bodies.
  #
  # source://rackup//lib/rackup/stream.rb#169
  def close(error = T.unsafe(nil)); end

  # source://rackup//lib/rackup/stream.rb#154
  def close_read; end

  # close must never be called on the input stream. huh?
  #
  # source://rackup//lib/rackup/stream.rb#160
  def close_write; end

  # Whether the stream has been closed.
  #
  # @return [Boolean]
  #
  # source://rackup//lib/rackup/stream.rb#179
  def closed?; end

  # Whether there are any output chunks remaining?
  #
  # @return [Boolean]
  #
  # source://rackup//lib/rackup/stream.rb#184
  def empty?; end

  # source://rackup//lib/rackup/stream.rb#151
  def flush; end

  # Returns the value of attribute input.
  #
  # source://rackup//lib/rackup/stream.rb#20
  def input; end

  # Returns the value of attribute output.
  #
  # source://rackup//lib/rackup/stream.rb#21
  def output; end

  # source://rackup//lib/rackup/stream.rb#134
  def write(buffer); end

  # source://rackup//lib/rackup/stream.rb#143
  def write_nonblock(buffer); end

  private

  # source://rackup//lib/rackup/stream.rb#190
  def read_next; end
end

# This provides a read-only interface for data, which is surprisingly tricky to implement correctly.
#
# source://rackup//lib/rackup/stream.rb#24
module Rackup::Stream::Reader
  # source://rackup//lib/rackup/stream.rb#99
  def each; end

  # source://rackup//lib/rackup/stream.rb#95
  def gets; end

  # read behaves like IO#read. Its signature is read([length, [buffer]]). If given, length must be a non-negative Integer (>= 0) or nil, and buffer must be a String and may not be nil. If length is given and not nil, then this method reads at most length bytes from the input stream. If length is not given or nil, then this method reads all data until EOF. When EOF is reached, this method returns nil if length is given and not nil, or “” if length is not given or is nil. If buffer is given, then the read data will be placed into buffer instead of a newly created String object.
  #
  # @param length [Integer] the amount of data to read
  # @param buffer [String] the buffer which will receive the data
  # @return a buffer containing the data
  #
  # source://rackup//lib/rackup/stream.rb#32
  def read(length = T.unsafe(nil), buffer = T.unsafe(nil)); end

  # source://rackup//lib/rackup/stream.rb#105
  def read_nonblock(length, buffer = T.unsafe(nil)); end

  # Read at most `length` bytes from the stream. Will avoid reading from the underlying stream if possible.
  #
  # source://rackup//lib/rackup/stream.rb#74
  def read_partial(length = T.unsafe(nil)); end
end

# source://rackup//lib/rackup/version.rb#7
Rackup::VERSION = T.let(T.unsafe(nil), String)
