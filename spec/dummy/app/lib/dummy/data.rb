# typed: strict

class Dummy::Data
  extend T::Sig

  MAX_INT = 2147483647

  RangeError = Class.new(StandardError)

  @data = T.let({}, T::Hash[String, Integer])
  @tracks = T.let([], T::Array[String])

  sig { params(data: T::Hash[String, Integer]).void }
  def self.reset(data)
    @data = data
    @tracks = []
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

  sig { params(str: String).void }
  def self.track(str)
    @tracks.push(str)
  end

  sig { returns(T::Array[String]) }
  def self.tracks
    @tracks
  end
end
