# typed: strict

require "rails"
require "coil/version"
require "coil/engine"
require "coil/queue_locking"

module Coil
  mattr_accessor :sidekiq_queue, default: "default"
end
