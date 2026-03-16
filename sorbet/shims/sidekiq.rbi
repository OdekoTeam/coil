# typed: true

class Sidekiq::Queue
  sig { params(name: String).void }
  def initialize(name = "default"); end

  sig { returns(Float) }
  def latency; end
end
