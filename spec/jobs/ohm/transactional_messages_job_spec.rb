require "rails_helper"

RSpec.shared_examples :transactional_messages_job do
  it "does nothing if no message is next in line" do
    random_key = SecureRandom.hex
    expect(job).not_to receive(:process)
    expect { job.perform(random_key) }
  end

  it "creates processor_completions" do
    expect { job.perform(key) }
      .to change(completions(message1), :count).by(1)
      .and change(completions(message2), :count).by(1)

    expect(completions(message1).last.processor_name)
      .to eq(job.class.name)
    expect(completions(message2).last.processor_name)
      .to eq(job.class.name)
  end

  it "allows processor_name to be overridden" do
    expect { job.perform(key, "EventReplay:2023-05-24") }
      .to change(completions(message1), :count).by(1)
      .and change(completions(message2), :count).by(1)

    expect(completions(message1).last.processor_name)
      .to eq("EventReplay:2023-05-24")
    expect(completions(message2).last.processor_name)
      .to eq("EventReplay:2023-05-24")
  end

  it "does not enqueue a subsequent job" do
    expect { job.perform(key) }
      .not_to change(job.class.jobs, :size)
  end

  it "does not re-process messages already processed by same processor" do
    job.perform(key)
    expect { job.perform(key) }
      .to change(completions(message1), :count).by(0)
      .and change(completions(message2), :count).by(0)
  end

  it "does process messages already processed by a different processor" do
    job.perform(key)
    expect { job.perform(key, "EventReplay:2023-05-24") }
      .to change(completions(message1), :count).by(1)
      .and change(completions(message2), :count).by(1)
  end

  it "is a no-op if all messages have already been processed" do
    message1.processed(processor_name: job.class.name)
    message2.processed(processor_name: job.class.name)
    expect(job).not_to receive(:process)
  end

  context "when unable to process all messages before deadline" do
    before(:each) do
      stub_const("Ohm::TransactionalMessagesJob::MAX_DURATION", 0.01.seconds)
      allow(job)
        .to receive(:process)
        .and_wrap_original do |m, *args|
          sleep(0.02)
          m.call(*args)
        end
    end

    it "enqueues a subsequent job" do
      processor_name = job.class.name
      expect { job.perform(key) }
        .to change(message1.class.unprocessed(processor_name:), :count).by(-1)
        .and change(job.class.jobs, :size).by(1)

      expect(message2.reload.processed?(processor_name:)).to eq(false)
      expect(job.class.jobs.last["args"]).to eq([key, processor_name])
    end
  end

  it "finishes job early if a duplicate job is detected" do
    allow(message1.class)
      .to receive(:locking_process_queue)
      .with(keys: [key], wait: false)
      .and_raise(Ohm::QueueLocking::LockWaitTimeout)

    expect(job).not_to receive(:process)

    job.perform(key)
  end
end

RSpec.describe Ohm::TransactionalMessagesJob do
  let(:data) { Dummy::Data }
  let(:events) { Dummy::Events }

  before(:each) do
    data.reset("a" => 0, "b" => 0, "c" => 0)
    events.reset([])
    # In case something goes wrong, we don't want to wait 5 minutes.
    stub_const("Ohm::TransactionalMessagesJob::MAX_DURATION", 5.seconds)
  end

  describe "#perform" do
    let(:key) { "k" }
    let(:value1) do
      {
        "foo_data" => [
          {"id" => "a", "val" => 100},
          {"id" => "b", "val" => 200}
        ]
      }
    end
    let(:value2) do
      {
        "foo_data" => [
          {"id" => "b", "val" => 250},
          {"id" => "c", "val" => 300}
        ]
      }
    end

    def completions(message)
      message.class::COMPLETION.where(
        message_type: message.type,
        message_key: message.key
      )
    end

    context "inbox" do
      let!(:message1) do
        Dummy::Inbox::FooMessage.create!(key:, value: value1, metadata: {})
      end
      let!(:message2) do
        Dummy::Inbox::FooMessage.create!(key:, value: value2, metadata: {})
      end
      let(:job) { Dummy::Inbox::FooMessagesJob.new }

      it_behaves_like :transactional_messages_job

      it "processes messages" do
        expect { job.perform(key) }
          .to change { data.get("a") }.to(100)
          .and change { data.get("b") }.to(250)
          .and change { data.get("c") }.to(300)
      end

      it "processes each message in a separate transaction" do
        msg1_a_data = message1.value["foo_data"].first
        msg1_b_data = message1.value["foo_data"].last
        msg2_b_data = message2.value["foo_data"].first

        msg2_b_data["val"] = data::MAX_INT + 1
        message2.save!

        old_c_val = data.get("c")

        expect { job.perform(key) }.to raise_error(data::RangeError)
        expect(data.get("a")).to eq(msg1_a_data["val"])
        expect(data.get("b")).to eq(msg1_b_data["val"])
        expect(data.get("c")).to eq(old_c_val)
      end

      it "prevents duplicate jobs from processing messages out of order" do
        allow_any_instance_of(message1.class).to(
          receive(:processed).and_wrap_original do |m, *args|
            sleep 0.4 if m.receiver == message1
            m.call(*args)
          end
        )

        expect {
          thread1 = Thread.new do
            job.perform(key)
          end
          thread2 = Thread.new do
            sleep 0.1
            job.perform(key)
          end
          [thread1, thread2].each(&:join)
        }.to change { data.get("a") }.to(100)
          .and change { data.get("b") }.to(250)
          .and change { data.get("c") }.to(300)
      end
    end

    context "outbox" do
      let!(:message1) do
        Dummy::Outbox::FooMessage.create!(key:, value: value1, metadata: {})
      end
      let!(:message2) do
        Dummy::Outbox::FooMessage.create!(key:, value: value2, metadata: {})
      end
      let(:job) { Dummy::Outbox::FooMessagesJob.new }

      it_behaves_like :transactional_messages_job

      it "processes messages" do
        metadata = {
          "value_schema_subject" => "com.example.Test_value",
          "value_schema_id" => 1000,
          "value_schema_version" => 1
        }
        expect { job.perform(key) }
          .to change { events.all }
          .to(
            [
              {"id" => "a", "val" => 100, "metadata" => metadata},
              {"id" => "b", "val" => 200, "metadata" => metadata},
              {"id" => "b", "val" => 250, "metadata" => metadata},
              {"id" => "c", "val" => 300, "metadata" => metadata}
            ]
          )
      end

      it "processes each message in a separate transaction" do
        msg2_b_data = message2.value["foo_data"].first
        msg2_b_data["val"] = "garbage"
        message2.save!

        metadata = {
          "value_schema_subject" => "com.example.Test_value",
          "value_schema_id" => 1000,
          "value_schema_version" => 1
        }

        expect { job.perform(key) }.to raise_error(events::SchemaError)
        expect(events.all).to eq(
          [
            {"id" => "a", "val" => 100, "metadata" => metadata},
            {"id" => "b", "val" => 200, "metadata" => metadata}
          ]
        )
      end

      it "prevents duplicate jobs from processing messages out of order" do
        allow_any_instance_of(message1.class).to(
          receive(:processed).and_wrap_original do |m, *args|
            sleep 0.4 if m.receiver == message1
            m.call(*args)
          end
        )
        metadata = {
          "value_schema_subject" => "com.example.Test_value",
          "value_schema_id" => 1000,
          "value_schema_version" => 1
        }

        expect {
          thread1 = Thread.new do
            job.perform(key)
          end
          thread2 = Thread.new do
            sleep 0.1
            job.perform(key)
          end
          [thread1, thread2].each(&:join)
        }.to change { events.all }.to(
          [
            {"id" => "a", "val" => 100, "metadata" => metadata},
            {"id" => "b", "val" => 200, "metadata" => metadata},
            {"id" => "b", "val" => 250, "metadata" => metadata},
            {"id" => "c", "val" => 300, "metadata" => metadata}
          ]
        )
      end
    end
  end
end
