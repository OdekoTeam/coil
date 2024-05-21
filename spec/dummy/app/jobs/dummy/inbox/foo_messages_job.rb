class Dummy::Inbox::FooMessagesJob < Ohm::TransactionalMessagesJob
  private

  def process(message)
    message.value["foo_data"].each do |d|
      Dummy::Data.set(d["id"], d["val"])
    end
  end

  def message_class
    Dummy::Inbox::FooMessage
  end
end
