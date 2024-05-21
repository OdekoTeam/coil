class Dummy::Data
  MAX_INT = 2147483647

  RangeError = Class.new(StandardError)

  def self.reset(data)
    @data = data
  end

  def self.get(id)
    @data.fetch(id)
  end

  def self.set(id, val)
    raise RangeError if val > MAX_INT
    @data[id] = val
  end
end
