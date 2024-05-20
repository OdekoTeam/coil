module Ohm
  class Engine < ::Rails::Engine
    isolate_namespace Ohm
    config.generators.api_only = true
    config.generators.test_framework = :rspec
  end
end
