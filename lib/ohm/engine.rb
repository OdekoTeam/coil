# typed: strict

module Ohm
  class Engine < ::Rails::Engine
    isolate_namespace Ohm
    config.generators.api_only = true
    config.generators.test_framework = :rspec

    initializer "ohm.enable_pg_xid8" do
      require "pg_xid8"
    end
  end
end
