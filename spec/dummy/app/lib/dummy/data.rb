# typed: strict

class Dummy::Data
  extend T::Sig

  MAX_INT = 2147483647

  RangeError = Class.new(StandardError)

  @data = T.let({}, T::Hash[String, Integer])

  sig { params(data: T::Hash[String, Integer]).void }
  def self.reset(data)
    @data = data
  end

  sig { params(id: String).returns(Integer) }
  def self.get(id)
    @data.fetch(id)
  end

  sig { params(id: String, val: Integer).void }
  def self.set(id, val)
    raise RangeError if val > MAX_INT
    @data[id] = val
  end
end
