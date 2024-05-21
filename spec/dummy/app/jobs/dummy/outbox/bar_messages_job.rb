class Dummy::Outbox::BarMessagesJob < Ohm::TransactionalMessagesJob
  private

  def pre_process(message)
    message.update!(
      metadata: {
        "value_schema_subject" => "com.example.Test_value",
        "value_schema_id" => 1000,
        "value_schema_version" => 1
      }
    )
  end

  def process(message)
    metadata = message.metadata
    message.value["bar_data"].each do |d|
      Dummy::Events.push(d.merge("metadata" => metadata))
    end
  end

  def message_class
    Dummy::Outbox::BarMessage
  end
end
