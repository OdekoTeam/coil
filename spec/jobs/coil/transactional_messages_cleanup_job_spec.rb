require "rails_helper"

RSpec.shared_examples :transactional_messages_cleanup_job do
  let(:created_at) do
    1.second.ago - retention_period
  end

  let!(:foo_message_w) do
    box::FooMessage.create!(key: "w", value: {}, metadata: {}, created_at:)
  end
  let!(:bar_message_x) do
    box::BarMessage.create!(key: "x", value: {}, metadata: {}, created_at:)
  end
  let!(:bar_message_y) do
    box::BarMessage.create!(key: "y", value: {}, metadata: {}, created_at:)
  end
  let!(:bar_message_z_1) do
    box::BarMessage.create!(key: "z", value: {}, metadata: {}, created_at:)
  end
  let!(:bar_message_z_2) do
    box::BarMessage.create!(key: "z", value: {}, metadata: {}, created_at:)
  end

  def process_all(except: [])
    all = [
      foo_message_w,
      bar_message_x,
      bar_message_y,
      bar_message_z_1,
      bar_message_z_2
    ]
    (all - except).each { |m| m.processed(processor_name: m.job_class.to_s) }
  end

  it "does nothing if no messages have been processed" do
    expect { cleanup_job.perform }
      .to change(box::FooMessage, :count).by(0)
      .and change(box::BarMessage, :count).by(0)
  end

  it "deletes processed messages whose retention period has passed" do
    process_all

    expect { cleanup_job.perform }
      .to change(box::FooMessage, :count).by(-1)
      .and change(box::BarMessage, :count).by(-4)
  end

  it "keeps processed messages whose retention period has not passed" do
    bar_message_x.update!(created_at: 1.minute.from_now - retention_period)
    process_all

    expect { cleanup_job.perform }
      .to change(box::FooMessage, :count).by(-1)
      .and change(box::BarMessage, :count).by(-3)
  end

  it "keeps unprocessed messages" do
    process_all(except: [bar_message_x])

    expect { cleanup_job.perform }
      .to change(box::FooMessage, :count).by(-1)
      .and change(box::BarMessage, :count).by(-3)
  end

  it "ignores processors other than the message's default job processor" do
    process_all(except: [bar_message_x])
    bar_message_x.processed(processor_name: "AdditionalProcessorX")
    bar_message_y.processed(processor_name: "AdditionalProcessorY")

    expect { cleanup_job.perform }
      .to change(box::FooMessage, :count).by(-1)
      .and change(box::BarMessage, :count).by(-3)
  end

  it "does not enqueue a subsequent job" do
    process_all

    expect { cleanup_job.perform }
      .not_to change(cleanup_job.class.jobs, :size)
  end

  context "when unable to clean up all messages before deadline" do
    before(:each) do
      stub_const("Coil::TransactionalMessagesCleanupJob::MAX_DURATION", 0.01.seconds)
      allow_any_instance_of(ActiveRecord::Relation)
        .to receive(:delete_all)
        .and_wrap_original do |m|
          sleep(0.02)
          m.call
        end
    end

    it "enqueues a subsequent job" do
      process_all
      batch_size = rand(1..1000)

      expect { cleanup_job.perform(batch_size) }
        .to change { box::FooMessage.count + box::BarMessage.count }
        .and change(cleanup_job.class.jobs, :size).by(1)

      j = cleanup_job.class.jobs.last
      expect(j["args"]).to eq([batch_size])
    end
  end

  it "finishes job early if a duplicate job is detected" do
    c = cleanup_job.class
    allow(Coil::QueueLocking)
      .to receive(:locking)
      .with(
        queue_type: c::QUEUE_TYPE,
        message_type: cleanup_job.send(:message_parent_class).to_s,
        message_keys: [c.to_s],
        wait: false
      )
      .and_raise(Coil::QueueLocking::LockWaitTimeout)

    expect { cleanup_job.perform }
      .not_to change { box::FooMessage.count + box::BarMessage.count }
  end
end

RSpec.describe Coil::TransactionalMessagesCleanupJob do
  describe "#perform" do
    context "inbox" do
      let(:cleanup_job) { Coil::Inbox::MessagesCleanupJob.new }
      let(:box) { Dummy::Inbox }
      let(:retention_period) { Coil.inbox_retention_period }

      it_behaves_like :transactional_messages_cleanup_job
    end

    context "outbox" do
      let(:cleanup_job) { Coil::Outbox::MessagesCleanupJob.new }
      let(:box) { Dummy::Outbox }
      let(:retention_period) { Coil.outbox_retention_period }

      it_behaves_like :transactional_messages_cleanup_job
    end
  end
end
