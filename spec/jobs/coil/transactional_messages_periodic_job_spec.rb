require "rails_helper"

RSpec.shared_examples :transactional_messages_periodic_job do
  let(:created_at) do
    1.second.ago - Coil::TransactionalMessagesJob::MAX_DURATION
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

  it "enqueues jobs to process unprocessed messages" do
    expect { periodic_job.perform }
      .to change(box::FooMessagesJob.jobs, :size).by(1)
      .and change(box::BarMessagesJob.jobs, :size).by(3)

    foo_a_job = box::FooMessagesJob.jobs.last
    expect(foo_a_job["args"]).to eq(["w"])

    bar_jobs = box::BarMessagesJob.jobs.last(3)
    expect(bar_jobs.map { _1["args"] }).to contain_exactly(["x"], ["y"], ["z"])
  end

  it "ignores very recent messages" do
    bar_message_x.update!(created_at: 1.second.ago)

    expect { periodic_job.perform }
      .to change(box::FooMessagesJob.jobs, :size).by(1)
      .and change(box::BarMessagesJob.jobs, :size).by(2)

    bar_jobs = box::BarMessagesJob.jobs.last(2)
    expect(bar_jobs.map { _1["args"] }).to contain_exactly(["y"], ["z"])
  end

  it "ignores messages that were already processed" do
    foo_message_w.processed(processor_name: box::FooMessagesJob.name)

    expect { periodic_job.perform }
      .to change(box::FooMessagesJob.jobs, :size).by(0)
      .and change(box::BarMessagesJob.jobs, :size).by(3)
  end

  it "ignores messages whose class cannot be found" do
    parent_class = periodic_job.send(:message_parent_class)
    legacy_type = parent_class.name.sub(/::[A-Z][A-Za-z]*\z/, "::LegacyType")
    parent_class.where(id: bar_message_x.id).update_all(type: legacy_type)

    expect { periodic_job.perform }
      .to change(box::FooMessagesJob.jobs, :size).by(1)
      .and change(box::BarMessagesJob.jobs, :size).by(2)

    bar_jobs = box::BarMessagesJob.jobs.last(2)
    expect(bar_jobs.map { _1["args"] }).to contain_exactly(["y"], ["z"])
  end
end

RSpec.describe Coil::TransactionalMessagesPeriodicJob do
  describe "#perform" do
    context "inbox" do
      let(:periodic_job) { Coil::Inbox::MessagesPeriodicJob.new }
      let(:box) { Dummy::Inbox }

      it_behaves_like :transactional_messages_periodic_job
    end

    context "outbox" do
      let(:periodic_job) { Coil::Outbox::MessagesPeriodicJob.new }
      let(:box) { Dummy::Outbox }

      it_behaves_like :transactional_messages_periodic_job
    end
  end
end
