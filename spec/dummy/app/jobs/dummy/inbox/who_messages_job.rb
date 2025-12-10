# typed: strict

class Dummy::Inbox::WhoMessagesJob < Coil::TransactionalMessagesJob
  extend T::Sig

  A = TypeAliases

  class_attribute :whodunnit

  private

  sig do
    override
      .type_parameters(:P)
      .params(
        message: A::AnyMessage,
        processor_name: String,
        blk: T.proc.returns(T.type_parameter(:P))
      ).returns(T.type_parameter(:P))
  end
  def around_process(message, processor_name:, &blk)
    old_whodunnit = self.class.whodunnit
    begin
      self.class.whodunnit = processor_name
      blk.call
    ensure
      self.class.whodunnit = old_whodunnit
    end
  end

  sig { override.params(message: A::AnyMessage).void }
  def process(message)
    msg = T.cast(message, Dummy::Inbox::WhoMessage)
    msg.value["who_data"].each do |d|
      Dummy::Data.set(d["id"], d["val"])
      Dummy::Data.track("#{self.class.whodunnit}|#{d["id"]}|#{d["val"]}")
    end
  end

  sig { override.returns(A::AnyMessageClass) }
  def message_class
    Dummy::Inbox::WhoMessage
  end
end
