# Usage:
#
#   let(:message) do
#     Dummy::Inbox::FooMessage.new(...)
#   end
#
#   it_behaves_like :enqueue_messages_job
#
RSpec.shared_examples :enqueue_messages_job do
  let(:job_class) { message.job_class }

  describe "after_commit" do
    it "enqueues job on create" do
      expect { message.save! }
        .to change(job_class.jobs, :count)
        .by(1)

      job_class = message.job_class
      job = job_class.jobs.last

      expect(job["args"]).to eq([message.key, job_class.name])
    end

    it "does not enqueue job on update" do
      message.save!
      expect { message.update!(key: "abc") }
        .not_to change(job_class.jobs, :count)
    end

    it "does not enqueue job on destroy" do
      message.save!
      expect { message.destroy! }
        .not_to change(job_class.jobs, :count)
    end
  end
end
