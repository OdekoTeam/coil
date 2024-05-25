# typed: strict

class Dummy::Inbox::BarMessagesJob < Ohm::TransactionalMessagesJob
  extend T::Sig

  private

  sig { override.params(message: Ohm::AnyMessage).void }
  def process(message)
    msg = T.cast(message, Dummy::Inbox::BarMessage)
    msg.value["bar_data"].each do |d|
      Dummy::Data.set(d["id"], d["val"])
    end
  end

  sig { override.returns(Ohm::AnyMessageClass) }
  def message_class
    Dummy::Inbox::BarMessage
  end
end
