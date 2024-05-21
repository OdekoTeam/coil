# Usage:
#
#   let(:message) do
#     Dummy::Inbox::FooMessage.new(...)
#   end
#   let(:different_type_message) do
#     Dummy::Inbox::BarMessage.new(...)
#   end
#
#   it_behaves_like :transactional_message
#
RSpec.shared_examples :transactional_message do
  let(:job_class) { message.job_class }
  let(:processor_name) { job_class.name }

  describe "#valid?" do
    it "is true with valid attributes" do
      expect(message).to be_valid
    end

    it "is false if key is blank" do
      message.key = " "
      expect(message).not_to be_valid
      expect(message.errors.attribute_names).to eq([:key])
    end
  end

  describe "#processed?" do
    before(:each) { message.save! }

    it "is true for the last processed message" do
      message.processed(processor_name:)
      expect(message.processed?(processor_name:)).to eq(true)
    end

    it "is true for messages before the last processed message" do
      message2 = message.dup.tap(&:save!)
      message.processed(processor_name:)
      message2.processed(processor_name:)
      expect(message.processed?(processor_name:)).to eq(true)
    end

    it "is false for messages after the last processed message" do
      message2 = message.dup.tap(&:save!)
      message.processed(processor_name:)
      expect(message2.processed?(processor_name:)).to eq(false)
    end

    it "is false if no messages have been processed" do
      expect(message.processed?(processor_name:)).to eq(false)
    end

    it "ignores other processor names" do
      message.processed(processor_name: "OtherProcessor")
      expect(message.processed?(processor_name:)).to eq(false)
    end

    it "ignores other message types" do
      different_type_message.update!(key: message.key)
      different_type_message.processed(processor_name:)
      expect(message.processed?(processor_name:)).to eq(false)
    end

    it "ignores other message keys" do
      message_x = message.dup.tap { |m| m.update!(key: SecureRandom.uuid) }
      message_x.processed(processor_name:)
      expect(message.processed?(processor_name:)).to eq(false)
    end

    it "handles complex keys" do
      message.update!(key: {a: 1, b: 2})
      message.processed(processor_name:)
      message.update!(key: {b: 2, a: 1})
      expect(message.processed?(processor_name:)).to eq(true)
    end
  end

  describe "#processed" do
    before(:each) { message.save! }

    let(:completions) { message.class::COMPLETION }

    it "records completion" do
      expect { message.processed(processor_name:) }
        .to change(completions, :count)
        .by(1)

      c = completions.last
      expect(c.processor_name).to eq(processor_name)
      expect(c.message_type).to eq(message.type)
      expect(c.message_key).to eq(message.key)
      expect(c.last_completed_message_id).to eq(message.id)
    end

    it "updates completion if recorded from an earlier message" do
      message2 = message.dup.tap(&:save!)
      message.processed(processor_name:)
      c = completions.last

      expect { message2.processed(processor_name:) }
        .to change(completions, :count)
        .by(0)
        .and change { c.reload.last_completed_message_id }
        .to(message2.id)
    end

    it "handles complex keys" do
      message.update!(key: {a: 1, b: 2})
      message2 = message.dup.tap { |m| m.update!(key: {b: 2, a: 1}) }
      message.processed(processor_name:)
      c = completions.last

      expect { message2.processed(processor_name:) }
        .to change(completions, :count)
        .by(0)
        .and change { c.reload.last_completed_message_id }
        .to(message2.id)
    end
  end

  describe "#unprocessed_predecessors" do
    before(:each) { message.save! }

    it "includes unprocessed messages with same type and key, but smaller id" do
      message2 = message.dup.tap(&:save!)
      expect(message2.unprocessed_predecessors(processor_name:))
        .to contain_exactly(message)
    end

    it "excludes unprocessed messages with different type" do
      different_type_message.update!(key: message.key)
      expect(different_type_message.unprocessed_predecessors(processor_name:))
        .to be_empty
    end

    it "excludes unprocessed messages with different key" do
      message2 = message.dup.tap { |m| m.update!(key: SecureRandom.uuid) }
      expect(message2.unprocessed_predecessors(processor_name:))
        .to be_empty
    end

    it "excludes unprocessed messages with same or greater id" do
      message.dup.tap(&:save!)
      expect(message.unprocessed_predecessors(processor_name:))
        .to be_empty
    end

    it "excludes processed messages" do
      message2 = message.dup.tap(&:save!)
      message.processed(processor_name:)

      expect(message2.unprocessed_predecessors(processor_name:))
        .to be_empty
      expect(message2.unprocessed_predecessors(processor_name: "OtherProcessor"))
        .to contain_exactly(message)
    end

    it "handles complex keys" do
      message.update!(key: {a: 1, b: 2})
      message2 = message.dup.tap { |m| m.update!(key: {b: 2, a: 1}) }
      expect(message2.unprocessed_predecessors(processor_name:))
        .to contain_exactly(message)
    end
  end

  describe ".processed" do
    before(:each) { message.save! }

    it "includes processed message" do
      message.processed(processor_name:)
      expect(message.class.processed(processor_name:)).to eq([message])
    end

    it "excludes unprocessed message" do
      expect(message.class.processed(processor_name:)).to be_empty
    end

    it "ignores other processor names" do
      message.processed(processor_name: "OtherProcessor")
      expect(message.class.processed(processor_name:)).to be_empty
    end

    it "ignores other message types" do
      different_type_message.update!(key: message.key)
      different_type_message.processed(processor_name:)
      expect(message.class.processed(processor_name:)).to be_empty
    end

    it "handles complex keys" do
      message.update!(key: {a: 1, b: 2})
      message.processed(processor_name:)
      expect(message.class.processed(processor_name:)).to eq([message])
    end

    context "given an array of processor names" do
      let(:name1) { job_class.name }
      let(:name2) { "LegacyJob" }

      it "includes message processed by one of the processors" do
        message.processed(processor_name: name2)
        expect(message.class.processed(processor_name: [name1, name2]))
          .to eq([message])
      end

      it "includes message processed by more than one of the processors" do
        message.processed(processor_name: name1)
        message.processed(processor_name: name2)
        expect(message.class.processed(processor_name: [name1, name2]))
          .to eq([message])
      end

      it "ignores other processor names" do
        message.processed(processor_name: "OtherProcessor")
        expect(message.class.processed(processor_name: [name1, name2]))
          .to be_empty
      end
    end
  end

  describe ".next_in_line" do
    before(:each) { message.save! }

    let!(:message2) { message.dup.tap(&:save!) }
    let(:key) { message.key }

    it "returns the next unprocessed message" do
      expect(message.class.next_in_line(key:, processor_name:)).to eq(message)
    end

    it "excludes processed message" do
      message.processed(processor_name:)
      expect(message.class.next_in_line(key:, processor_name:)).to eq(message2)
    end

    it "ignores other processor names" do
      message.processed(processor_name: "OtherProcessor")
      expect(message.class.next_in_line(key:, processor_name:)).to eq(message)
    end

    it "excludes other message types" do
      message.update!(type: different_type_message.type)
      expect(message.class.next_in_line(key:, processor_name:)).to eq(message2)
    end

    it "excludes other message keys" do
      key = message.key
      message.update!(key: SecureRandom.uuid)
      expect(message.class.next_in_line(key:, processor_name:)).to eq(message2)
    end

    it "returns nil when there are no unprocessed messages left" do
      [message, message2].each { |m| m.processed(processor_name:) }
      expect(message.class.next_in_line(key:, processor_name:)).to eq(nil)
    end

    it "handles complex keys" do
      message.update!(key: {a: 1, b: 2})
      expect(message.class.next_in_line(key: {b: 2, a: 1}, processor_name:))
        .to eq(message)
    end

    context "given an array of processor names" do
      let(:name1) { job_class.name }
      let(:name2) { "LegacyJob" }

      it "finds message not processed by any of the processors" do
        expect(message.class.next_in_line(key:, processor_name: [name1, name2]))
          .to eq(message)
      end

      it "excludes message processed by any of the processors" do
        message.processed(processor_name: name2)
        expect(message.class.next_in_line(key:, processor_name: [name1, name2]))
          .to eq(message2)
      end
    end
  end
end
