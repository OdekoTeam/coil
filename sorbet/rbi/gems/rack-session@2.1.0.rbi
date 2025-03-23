# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rack-session` gem.
# Please instead update this file by running `bin/tapioca gem rack-session`.


# source://rack-session//lib/rack/session/constants.rb#7
module Rack
  class << self
    # source://rack/3.1.12/lib/rack/version.rb#18
    def release; end
  end
end

# source://rack-session//lib/rack/session/constants.rb#8
module Rack::Session; end

# source://rack-session//lib/rack/session/abstract/id.rb#47
module Rack::Session::Abstract; end

# source://rack-session//lib/rack/session/abstract/id.rb#499
class Rack::Session::Abstract::ID < ::Rack::Session::Abstract::Persisted
  # source://rack-session//lib/rack/session/abstract/id.rb#529
  def delete_session(req, sid, options); end

  # source://rack-session//lib/rack/session/abstract/id.rb#514
  def find_session(req, sid); end

  # source://rack-session//lib/rack/session/abstract/id.rb#522
  def write_session(req, sid, session, options); end

  class << self
    # source://rack-session//lib/rack/session/abstract/id.rb#500
    def inherited(klass); end
  end
end

# source://rack-session//lib/rack/session/abstract/id.rb#239
class Rack::Session::Abstract::Persisted
  # source://rack-session//lib/rack/session/abstract/id.rb#257
  def initialize(app, options = T.unsafe(nil)); end

  # source://rack-session//lib/rack/session/abstract/id.rb#267
  def call(env); end

  # source://rack-session//lib/rack/session/abstract/id.rb#381
  def commit_session(req, res); end

  # source://rack-session//lib/rack/session/abstract/id.rb#271
  def context(env, app = T.unsafe(nil)); end

  # source://rack-session//lib/rack/session/abstract/id.rb#255
  def default_options; end

  # source://rack-session//lib/rack/session/abstract/id.rb#255
  def key; end

  # source://rack-session//lib/rack/session/abstract/id.rb#255
  def same_site; end

  # source://rack-session//lib/rack/session/abstract/id.rb#255
  def sid_secure; end

  private

  # source://rack-session//lib/rack/session/abstract/id.rb#350
  def commit_session?(req, session, options); end

  # source://rack-session//lib/rack/session/abstract/id.rb#416
  def cookie_value(data); end

  # source://rack-session//lib/rack/session/abstract/id.rb#336
  def current_session_id(req); end

  # source://rack-session//lib/rack/session/abstract/id.rb#455
  def delete_session(req, sid, options); end

  # source://rack-session//lib/rack/session/abstract/id.rb#328
  def extract_session_id(request); end

  # source://rack-session//lib/rack/session/abstract/id.rb#440
  def find_session(env, sid); end

  # source://rack-session//lib/rack/session/abstract/id.rb#367
  def force_options?(options); end

  # source://rack-session//lib/rack/session/abstract/id.rb#363
  def forced_session_update?(session, options); end

  # source://rack-session//lib/rack/session/abstract/id.rb#296
  def generate_sid(secure = T.unsafe(nil)); end

  # source://rack-session//lib/rack/session/abstract/id.rb#286
  def initialize_sid; end

  # source://rack-session//lib/rack/session/abstract/id.rb#320
  def load_session(req); end

  # source://rack-session//lib/rack/session/abstract/id.rb#359
  def loaded_session?(session); end

  # source://rack-session//lib/rack/session/abstract/id.rb#282
  def make_request(env); end

  # source://rack-session//lib/rack/session/abstract/id.rb#309
  def prepare_session(req); end

  # source://rack-session//lib/rack/session/abstract/id.rb#371
  def security_matches?(request, options); end

  # source://rack-session//lib/rack/session/abstract/id.rb#431
  def session_class; end

  # source://rack-session//lib/rack/session/abstract/id.rb#342
  def session_exists?(req); end

  # source://rack-session//lib/rack/session/abstract/id.rb#423
  def set_cookie(request, response, cookie); end

  # source://rack-session//lib/rack/session/abstract/id.rb#448
  def write_session(req, sid, session, options); end
end

# source://rack-session//lib/rack/session/abstract/id.rb#240
Rack::Session::Abstract::Persisted::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)

# source://rack-session//lib/rack/session/abstract/id.rb#460
class Rack::Session::Abstract::PersistedSecure < ::Rack::Session::Abstract::Persisted
  # source://rack-session//lib/rack/session/abstract/id.rb#483
  def extract_session_id(*_arg0); end

  # source://rack-session//lib/rack/session/abstract/id.rb#477
  def generate_sid(*_arg0); end

  private

  # source://rack-session//lib/rack/session/abstract/id.rb#494
  def cookie_value(data); end

  # source://rack-session//lib/rack/session/abstract/id.rb#490
  def session_class; end
end

# source://rack-session//lib/rack/session/abstract/id.rb#461
class Rack::Session::Abstract::PersistedSecure::SecureSessionHash < ::Rack::Session::Abstract::SessionHash
  # source://rack-session//lib/rack/session/abstract/id.rb#462
  def [](key); end
end

# source://rack-session//lib/rack/session/abstract/id.rb#50
class Rack::Session::Abstract::SessionHash
  include ::Enumerable

  # source://rack-session//lib/rack/session/abstract/id.rb#68
  def initialize(store, req); end

  # source://rack-session//lib/rack/session/abstract/id.rb#88
  def [](key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#114
  def []=(key, value); end

  # source://rack-session//lib/rack/session/abstract/id.rb#120
  def clear; end

  # source://rack-session//lib/rack/session/abstract/id.rb#146
  def delete(key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#125
  def destroy; end

  # source://rack-session//lib/rack/session/abstract/id.rb#93
  def dig(key, *keys); end

  # source://rack-session//lib/rack/session/abstract/id.rb#83
  def each(&block); end

  # source://rack-session//lib/rack/session/abstract/id.rb#169
  def empty?; end

  # source://rack-session//lib/rack/session/abstract/id.rb#159
  def exists?; end

  # source://rack-session//lib/rack/session/abstract/id.rb#98
  def fetch(key, default = T.unsafe(nil), &block); end

  # source://rack-session//lib/rack/session/abstract/id.rb#107
  def has_key?(key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#74
  def id; end

  # source://rack-session//lib/rack/session/abstract/id.rb#52
  def id=(_arg0); end

  # source://rack-session//lib/rack/session/abstract/id.rb#107
  def include?(key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#151
  def inspect; end

  # source://rack-session//lib/rack/session/abstract/id.rb#107
  def key?(key); end

  # source://rack-session//lib/rack/session/abstract/id.rb#174
  def keys; end

  # source://rack-session//lib/rack/session/abstract/id.rb#165
  def loaded?; end

  # source://rack-session//lib/rack/session/abstract/id.rb#135
  def merge!(hash); end

  # source://rack-session//lib/rack/session/abstract/id.rb#79
  def options; end

  # source://rack-session//lib/rack/session/abstract/id.rb#141
  def replace(hash); end

  # source://rack-session//lib/rack/session/abstract/id.rb#114
  def store(key, value); end

  # source://rack-session//lib/rack/session/abstract/id.rb#130
  def to_hash; end

  # source://rack-session//lib/rack/session/abstract/id.rb#135
  def update(hash); end

  # source://rack-session//lib/rack/session/abstract/id.rb#179
  def values; end

  private

  # source://rack-session//lib/rack/session/abstract/id.rb#194
  def load!; end

  # source://rack-session//lib/rack/session/abstract/id.rb#186
  def load_for_read!; end

  # source://rack-session//lib/rack/session/abstract/id.rb#190
  def load_for_write!; end

  # source://rack-session//lib/rack/session/abstract/id.rb#200
  def stringify_keys(other); end

  class << self
    # source://rack-session//lib/rack/session/abstract/id.rb#56
    def find(req); end

    # source://rack-session//lib/rack/session/abstract/id.rb#60
    def set(req, session); end

    # source://rack-session//lib/rack/session/abstract/id.rb#64
    def set_options(req, options); end
  end
end

# source://rack-session//lib/rack/session/abstract/id.rb#54
Rack::Session::Abstract::SessionHash::Unspecified = T.let(T.unsafe(nil), Object)

# source://rack-session//lib/rack/session/cookie.rb#91
class Rack::Session::Cookie < ::Rack::Session::Abstract::PersistedSecure
  # source://rack-session//lib/rack/session/cookie.rb#159
  def initialize(app, options = T.unsafe(nil)); end

  # source://rack-session//lib/rack/session/cookie.rb#157
  def coder; end

  # source://rack-session//lib/rack/session/cookie.rb#157
  def encryptors; end

  private

  # source://rack-session//lib/rack/session/cookie.rb#277
  def delete_session(req, session_id, options); end

  # source://rack-session//lib/rack/session/cookie.rb#292
  def encode_session_data(session); end

  # source://rack-session//lib/rack/session/cookie.rb#209
  def extract_session_id(request); end

  # source://rack-session//lib/rack/session/cookie.rb#203
  def find_session(req, sid); end

  # source://rack-session//lib/rack/session/cookie.rb#282
  def legacy_digest_match?(data, digest); end

  # source://rack-session//lib/rack/session/cookie.rb#288
  def legacy_generate_hmac(data); end

  # source://rack-session//lib/rack/session/cookie.rb#250
  def persistent_session_id!(data, sid = T.unsafe(nil)); end

  # source://rack-session//lib/rack/session/cookie.rb#306
  def secure?(options); end

  # source://rack-session//lib/rack/session/cookie.rb#213
  def unpacked_cookie_data(request); end

  # source://rack-session//lib/rack/session/cookie.rb#265
  def write_session(req, session_id, session, options); end
end

# source://rack-session//lib/rack/session/cookie.rb#93
class Rack::Session::Cookie::Base64
  # source://rack-session//lib/rack/session/cookie.rb#98
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#94
  def encode(str); end
end

# source://rack-session//lib/rack/session/cookie.rb#116
class Rack::Session::Cookie::Base64::JSON < ::Rack::Session::Cookie::Base64
  # source://rack-session//lib/rack/session/cookie.rb#121
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#117
  def encode(obj); end
end

# source://rack-session//lib/rack/session/cookie.rb#103
class Rack::Session::Cookie::Base64::Marshal < ::Rack::Session::Cookie::Base64
  # source://rack-session//lib/rack/session/cookie.rb#108
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#104
  def encode(str); end
end

# source://rack-session//lib/rack/session/cookie.rb#127
class Rack::Session::Cookie::Base64::ZipJSON < ::Rack::Session::Cookie::Base64
  # source://rack-session//lib/rack/session/cookie.rb#132
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#128
  def encode(obj); end
end

# source://rack-session//lib/rack/session/cookie.rb#142
class Rack::Session::Cookie::Identity
  # source://rack-session//lib/rack/session/cookie.rb#144
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#143
  def encode(str); end
end

# source://rack-session//lib/rack/session/cookie.rb#147
class Rack::Session::Cookie::Marshal
  # source://rack-session//lib/rack/session/cookie.rb#152
  def decode(str); end

  # source://rack-session//lib/rack/session/cookie.rb#148
  def encode(str); end
end

# source://rack-session//lib/rack/session/cookie.rb#256
class Rack::Session::Cookie::SessionId
  # source://rack-session//lib/rack/session/cookie.rb#259
  def initialize(session_id, cookie_value); end

  # source://rack-session//lib/rack/session/cookie.rb#257
  def cookie_value; end
end

# source://rack-session//lib/rack/session/encryptor.rb#16
class Rack::Session::Encryptor
  # source://rack-session//lib/rack/session/encryptor.rb#53
  def initialize(secret, opts = T.unsafe(nil)); end

  # source://rack-session//lib/rack/session/encryptor.rb#77
  def decrypt(base64_data); end

  # source://rack-session//lib/rack/session/encryptor.rb#102
  def encrypt(message); end

  private

  # source://rack-session//lib/rack/session/encryptor.rb#139
  def cipher_secret_from_message_secret(message_secret); end

  # source://rack-session//lib/rack/session/encryptor.rb#151
  def compute_signature(data); end

  # source://rack-session//lib/rack/session/encryptor.rb#182
  def deserialized_message(data); end

  # source://rack-session//lib/rack/session/encryptor.rb#129
  def new_cipher; end

  # source://rack-session//lib/rack/session/encryptor.rb#133
  def new_message_and_cipher_secret; end

  # source://rack-session//lib/rack/session/encryptor.rb#169
  def serialize_payload(message); end

  # source://rack-session//lib/rack/session/encryptor.rb#147
  def serializer; end

  # source://rack-session//lib/rack/session/encryptor.rb#143
  def set_cipher_key(cipher, key); end

  # source://rack-session//lib/rack/session/encryptor.rb#158
  def verify_authenticity!(data, signature); end
end

# source://rack-session//lib/rack/session/encryptor.rb#17
class Rack::Session::Encryptor::Error < ::StandardError; end

# source://rack-session//lib/rack/session/encryptor.rb#23
class Rack::Session::Encryptor::InvalidMessage < ::Rack::Session::Encryptor::Error; end

# source://rack-session//lib/rack/session/encryptor.rb#20
class Rack::Session::Encryptor::InvalidSignature < ::Rack::Session::Encryptor::Error; end

# source://rack-session//lib/rack/session/constants.rb#9
Rack::Session::RACK_SESSION = T.let(T.unsafe(nil), String)

# source://rack-session//lib/rack/session/constants.rb#10
Rack::Session::RACK_SESSION_OPTIONS = T.let(T.unsafe(nil), String)

# source://rack-session//lib/rack/session/constants.rb#11
Rack::Session::RACK_SESSION_UNPACKED_COOKIE_DATA = T.let(T.unsafe(nil), String)

# source://rack-session//lib/rack/session/abstract/id.rb#21
class Rack::Session::SessionId
  # source://rack-session//lib/rack/session/abstract/id.rb#26
  def initialize(public_id); end

  # source://rack-session//lib/rack/session/abstract/id.rb#24
  def cookie_value; end

  # source://rack-session//lib/rack/session/abstract/id.rb#37
  def empty?; end

  # source://rack-session//lib/rack/session/abstract/id.rb#38
  def inspect; end

  # source://rack-session//lib/rack/session/abstract/id.rb#30
  def private_id; end

  # source://rack-session//lib/rack/session/abstract/id.rb#24
  def public_id; end

  # source://rack-session//lib/rack/session/abstract/id.rb#24
  def to_s; end

  private

  # source://rack-session//lib/rack/session/abstract/id.rb#42
  def hash_sid(sid); end
end

# source://rack-session//lib/rack/session/abstract/id.rb#22
Rack::Session::SessionId::ID_VERSION = T.let(T.unsafe(nil), Integer)
