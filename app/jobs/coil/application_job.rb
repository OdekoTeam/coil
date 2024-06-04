# typed: strict

module Coil
  class ApplicationJob
    include Sidekiq::Job
  end
end
