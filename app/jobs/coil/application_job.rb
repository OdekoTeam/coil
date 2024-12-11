# typed: strict

module Coil
  class ApplicationJob
    include Sidekiq::Worker

    sidekiq_options queue: Coil.sidekiq_queue
  end
end
