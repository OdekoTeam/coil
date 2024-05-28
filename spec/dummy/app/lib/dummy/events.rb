# typed: strict

class Dummy::Events
  extend T::Sig

  SchemaError = Class.new(StandardError)

  Event = T.type_alias { T::Hash[String, T.untyped] }

  @events = T.let([], T::Array[Event])

  sig { params(events: T::Array[Event]).void }
  def self.reset(events)
    @events = events
  end

  sig { returns(T::Array[Event]) }
  def self.all
    @events
  end

  sig { params(event: Event).void }
  def self.push(event)
    raise SchemaError if event["val"].class != Integer
    @events.push(event)
  end
end
