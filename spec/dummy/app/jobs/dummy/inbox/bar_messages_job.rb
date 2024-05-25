class Dummy::Inbox::BarMessagesJob < Ohm::TransactionalMessagesJob
  private

  def process(message)
    message.value["bar_data"].each do |d|
      Dummy::Data.set(d["id"], d["val"])
    end
  end

  def message_class
    Dummy::Inbox::BarMessage
  end
end
