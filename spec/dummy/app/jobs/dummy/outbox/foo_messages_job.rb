# typed: strict

class Dummy::Outbox::FooMessagesJob < Coil::TransactionalMessagesJob
  extend T::Sig

  A = TypeAliases

  private

  sig { override.params(message: A::AnyMessage).void }
  def pre_process(message)
    msg = T.cast(message, Dummy::Outbox::FooMessage)
    msg.update!(
      metadata: {
        "value_schema_subject" => "com.example.Test_value",
        "value_schema_id" => 1000,
        "value_schema_version" => 1
      }
    )
  end

  sig { override.params(message: A::AnyMessage).void }
  def process(message)
    msg = T.cast(message, Dummy::Outbox::FooMessage)
    msg.value["foo_data"].each do |d|
      Dummy::Events.push(d.merge("metadata" => msg.metadata))
    end
  end

  sig { override.returns(A::AnyMessageClass) }
  def message_class
    Dummy::Outbox::FooMessage
  end
end
