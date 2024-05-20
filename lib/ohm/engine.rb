module Ohm
  class Engine < ::Rails::Engine
    isolate_namespace Ohm
    config.generators.api_only = true
  end
end
