# typed: strict

module Coil
  class ApplicationJob
    include Sidekiq::Worker
  end
end
