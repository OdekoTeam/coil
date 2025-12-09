# typed: strict

class Dummy::Inbox::FooMessagesJob < Coil::TransactionalMessagesJob
  extend T::Sig

  A = TypeAliases

  private

  sig { override.params(message: A::AnyMessage).void }
  def process(message)
    msg = T.cast(message, Dummy::Inbox::FooMessage)
    msg.value["foo_data"].each do |d|
      Dummy::Data.set(d["id"], d["val"])
    end
  end

  sig { override.returns(A::AnyMessageClass) }
  def message_class
    Dummy::Inbox::FooMessage
  end
end
