class Dummy::Events
  SchemaError = Class.new(StandardError)

  def self.reset(events)
    @events = []
  end

  def self.all
    @events
  end

  def self.push(event)
    raise SchemaError if event["val"].class != Integer
    @events.push(event)
  end
end
