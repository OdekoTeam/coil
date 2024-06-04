# typed: strict

module Coil
  class Engine < ::Rails::Engine
    isolate_namespace Coil
    config.generators.api_only = true
    config.generators.test_framework = :rspec
  end
end
