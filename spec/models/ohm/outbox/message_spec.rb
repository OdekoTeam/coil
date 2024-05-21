require "rails_helper"
require "support/shared_examples/enqueue_messages_job_examples"
require "support/shared_examples/transactional_message_examples"

RSpec.describe Ohm::Outbox::Message, type: :model do
  let(:message) do
    Dummy::Outbox::FooMessage.new(
      key: "x",
      value: {
        "foo_data" => [{"id" => "a", "val" => 0}]
      },
      metadata: {
        "value_schema_subject" => "com.example.Test_value",
        "value_schema_id" => 1000,
        "value_schema_version" => 1
      }
    )
  end
  let(:different_type_message) do
    Dummy::Outbox::BarMessage.new(
      key: "y",
      value: {
        "bar_data" => [{"id" => "b", "val" => 0}]
      },
      metadata: {
        "value_schema_subject" => "com.example.Test_value",
        "value_schema_id" => 1000,
        "value_schema_version" => 1
      }
    )
  end

  it_behaves_like :enqueue_messages_job
  it_behaves_like :transactional_message
end
