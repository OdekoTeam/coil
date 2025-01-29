# typed: strict

require "rails"
require "coil/version"
require "coil/engine"
require "coil/queue_locking"

module Coil
  mattr_accessor :sidekiq_queue, default: "default"
  mattr_accessor :inbox_retention_period, default: 12.weeks
  mattr_accessor :outbox_retention_period, default: 12.weeks
end
