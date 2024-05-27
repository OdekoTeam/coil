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

  def create_from(message, attrs = {})
    message.class.create!(
      message.attributes.except("xid", "id").merge(attrs)
    )
  end

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
      message2 = message.class.create!(message.attributes.except("xid", "id"))
      message.processed(processor_name:)
      message2.processed(processor_name:)
      expect(message.processed?(processor_name:)).to eq(true)
    end

    it "is false for messages after the last processed message" do
      message2 = message.class.create!(message.attributes.except("xid", "id"))
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
      message_x = message.class.create!(
        message.attributes.except("xid", "id").merge("key" => SecureRandom.uuid)
      )
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
      message2 = message.class.create!(message.attributes.except("xid", "id"))
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
      message2 = message.class.create!(
        message.attributes.except("xid", "id").merge("key" => {b: 2, a: 1})
      )
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

    it "includes unprocessed messages with same type and key, but smaller xid" do
      message2 = message.class.create!(message.attributes.except("xid", "id"))
      expect(message2.unprocessed_predecessors(processor_name:))
        .to contain_exactly(message)
    end

    it "includes unprocessed messages with same type, key and xid, but smaller id" do
      message2 = message.class.create!(message.attributes.except("id"))
      expect(message2.unprocessed_predecessors(processor_name:))
        .to contain_exactly(message)
    end

    it "excludes unprocessed messages with different type" do
      different_type_message.update!(key: message.key)
      expect(different_type_message.unprocessed_predecessors(processor_name:))
        .to be_empty
    end

    it "excludes unprocessed messages with different key" do
      message2 = message.class.create!(
        message.attributes.except("xid", "id").merge("key" => SecureRandom.uuid)
      )
      expect(message2.unprocessed_predecessors(processor_name:))
        .to be_empty
    end

    it "excludes unprocessed messages with same xid but greater id" do
      message.class.create!(message.attributes.except("id"))
      expect(message.unprocessed_predecessors(processor_name:))
        .to be_empty
    end

    it "excludes unprocessed messages with greater xid" do
      message.class.create!(message.attributes.except("xid", "id"))
      expect(message.unprocessed_predecessors(processor_name:))
        .to be_empty
    end

    it "excludes processed messages" do
      message2 = message.class.create!(message.attributes.except("xid", "id"))
      message.processed(processor_name:)

      expect(message2.unprocessed_predecessors(processor_name:))
        .to be_empty
      expect(message2.unprocessed_predecessors(processor_name: "OtherProcessor"))
        .to contain_exactly(message)
    end

    it "handles complex keys" do
      message.update!(key: {a: 1, b: 2})
      message2 = message.class.create!(
        message.attributes.except("xid", "id").merge("key" => {b: 2, a: 1})
      )
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

    let!(:message2) do
      message.class.create!(message.attributes.except("xid", "id"))
    end
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

    context "with concurrent transactions" do
      # Messages have an auto-incrementing id sequence whose values are consumed
      # on each insert statement. The sequence increment is immediately visible
      # to all other transactions, but the message itself is not visible until
      # we commit the transaction.
      #
      # We can't assume messages will be committed in the same order as their
      # id sequence. With concurrent db connections, a newly-committed message
      # could appear while another new message with a lower id is still in an
      # uncommitted state.
      #
      # We need to ensure that .next_in_line doesn't accidentally skip messages
      # in these scenarios.

      before(:each) do
        [message, message2].each { |m| m.processed(processor_name:) }
      end

      def new_message(attributes)
        message.class.new(
          message.attributes.except("xid", "id").merge(attributes)
        )
      end

      it "avoids skipping uncommitted messages (scenario 1)" do
        # CLIENT A| BEGIN..INSERT...............COMMIT
        # CLIENT B|    BEGIN..INSERT..COMMIT
        # CLIENT C|                        SELECT    SELECT
        client_a = Thread.new do
          ApplicationRecord.transaction do
            @a_begun = true
            new_message(metadata: {"client" => "a"}).save!
            @a_inserted = true
            sleep 0.01 until @selected1
          end
          @a_committed = true
        end
        client_b = Thread.new do
          sleep 0.01 until @a_begun
          ApplicationRecord.transaction do
            sleep 0.01 until @a_inserted
            new_message(metadata: {"client" => "b"}).save!
          end
          @b_committed = true
        end
        client_c = Thread.new do
          sleep 0.01 until @b_committed
          @unprocessed1 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line1 = message.class.next_in_line(key:, processor_name:)
          @selected1 = true
          sleep 0.01 until @a_committed
          @unprocessed2 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line2 = message.class.next_in_line(key:, processor_name:)
        end
        [client_a, client_b, client_c].each(&:join)

        expect(@unprocessed1.map { |m| m.metadata["client"] }).to eq(["b"])
        expect(@next_in_line1).to eq(nil)

        expect(@unprocessed2.map { |m| m.metadata["client"] }).to eq(["a", "b"])
        expect(@next_in_line2.metadata["client"]).to eq("a")
      end

      it "avoids skipping uncommitted messages (scenario 2)" do
        # CLIENT A| BEGIN...INSERT..................COMMIT
        # CLIENT B|    BEGIN...INSERT.........................COMMIT
        # CLIENT C|       BEGIN...INSERT..COMMIT
        # CLIENT D|                            SELECT    SELECT    SELECT
        client_a = Thread.new do
          ApplicationRecord.transaction do
            @a_begun = true
            new_message(metadata: {"client" => "a"}).save!
            @a_inserted = true
            sleep 0.01 until @selected1
          end
          @a_committed = true
        end
        client_b = Thread.new do
          sleep 0.01 until @a_begun
          ApplicationRecord.transaction do
            @b_begun = true
            sleep 0.01 until @a_inserted
            new_message(metadata: {"client" => "b"}).save!
            @b_inserted = true
            sleep 0.01 until @selected2
          end
          @b_committed = true
        end
        client_c = Thread.new do
          sleep 0.01 until @b_begun
          ApplicationRecord.transaction do
            sleep 0.01 until @b_inserted
            new_message(metadata: {"client" => "c"}).save!
          end
          @c_committed = true
        end
        client_d = Thread.new do
          sleep 0.01 until @c_committed
          @unprocessed1 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line1 = message.class.next_in_line(key:, processor_name:)
          @selected1 = true
          sleep 0.01 until @a_committed
          @unprocessed2 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line2 = message.class.next_in_line(key:, processor_name:)
          @selected2 = true
          sleep 0.01 until @b_committed
          @unprocessed3 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line3 = message.class.next_in_line(key:, processor_name:)
        end
        [client_a, client_b, client_c, client_d].each(&:join)

        expect(@unprocessed1.map { |m| m.metadata["client"] }).to eq(["c"])
        expect(@next_in_line1).to eq(nil)

        expect(@unprocessed2.map { |m| m.metadata["client"] }).to eq(["a", "c"])
        expect(@next_in_line2.metadata["client"]).to eq("a")

        expect(@unprocessed3.map { |m| m.metadata["client"] }).to eq(["a", "b", "c"])
        expect(@next_in_line3.metadata["client"]).to eq("a")
      end

      it "avoids skipping uncommitted messages (scenario 3)" do
        # CLIENT A| BEGIN..........INSERT...COMMIT
        # CLIENT B|    BEGIN...INSERT.................COMMIT
        # CLIENT C|       BEGIN........INSERT...................COMMIT
        # CLIENT D|                              SELECT    SELECT    SELECT
        client_a = Thread.new do
          ApplicationRecord.transaction do
            @a_begun = true
            sleep 0.01 until @b_inserted
            new_message(metadata: {"client" => "a"}).save!
            @a_inserted = true
            sleep 0.01 until @c_inserted
          end
          @a_committed = true
        end
        client_b = Thread.new do
          sleep 0.01 until @a_begun
          ApplicationRecord.transaction do
            @b_begun = true
            sleep 0.01 until @c_begun
            new_message(metadata: {"client" => "b"}).save!
            @b_inserted = true
            sleep 0.01 until @selected1
          end
          @b_committed = true
        end
        client_c = Thread.new do
          sleep 0.01 until @b_begun
          ApplicationRecord.transaction do
            @c_begun = true
            sleep 0.01 until @a_inserted
            new_message(metadata: {"client" => "c"}).save!
            @c_inserted = true
            sleep 0.01 until @selected2
          end
          @c_committed = true
        end
        client_d = Thread.new do
          sleep 0.01 until @a_committed
          @unprocessed1 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line1 = message.class.next_in_line(key:, processor_name:)
          @selected1 = true
          sleep 0.01 until @b_committed
          @unprocessed2 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line2 = message.class.next_in_line(key:, processor_name:)
          @selected2 = true
          sleep 0.01 until @c_committed
          @unprocessed3 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line3 = message.class.next_in_line(key:, processor_name:)
        end
        [client_a, client_b, client_c, client_d].each(&:join)

        expect(@unprocessed1.map { |m| m.metadata["client"] }).to eq(["a"])
        expect(@next_in_line1).to eq(nil)

        expect(@unprocessed2.map { |m| m.metadata["client"] }).to eq(["b", "a"])
        expect(@next_in_line3.metadata["client"]).to eq("b")

        expect(@unprocessed3.map { |m| m.metadata["client"] }).to eq(["b", "a", "c"])
        expect(@next_in_line3.metadata["client"]).to eq("b")
      end

      it "avoids skipping uncommitted messages (scenario 4)" do
        # CLIENT A| BEGIN...INSERT..................COMMIT
        # CLIENT B|    BEGIN...INSERT..........................................COMMIT
        # CLIENT C|       BEGIN...INSERT..COMMIT
        # CLIENT D|                            SELECT    SELECT  PROCESS  SELECT    SELECT
        client_a = Thread.new do
          ApplicationRecord.transaction do
            @a_begun = true
            new_message(metadata: {"client" => "a"}).save!
            @a_inserted = true
            sleep 0.01 until @selected1
          end
          @a_committed = true
        end
        client_b = Thread.new do
          sleep 0.01 until @a_begun
          ApplicationRecord.transaction do
            @b_begun = true
            sleep 0.01 until @a_inserted
            new_message(metadata: {"client" => "b"}).save!
            @b_inserted = true
            sleep 0.01 until @selected3
          end
          @b_committed = true
        end
        client_c = Thread.new do
          sleep 0.01 until @b_begun
          ApplicationRecord.transaction do
            sleep 0.01 until @b_inserted
            new_message(metadata: {"client" => "c"}).save!
          end
          @c_committed = true
        end
        client_d = Thread.new do
          sleep 0.01 until @c_committed
          @unprocessed1 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line1 = message.class.next_in_line(key:, processor_name:)
          @selected1 = true
          sleep 0.01 until @a_committed
          @unprocessed2 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line2 = message.class.next_in_line(key:, processor_name:)
          @selected2 = true
          @next_in_line2.processed(processor_name:)
          @unprocessed3 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line3 = message.class.next_in_line(key:, processor_name:)
          @selected3 = true
          sleep 0.01 until @b_committed
          @unprocessed4 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line4 = message.class.next_in_line(key:, processor_name:)
        end
        [client_a, client_b, client_c, client_d].each(&:join)

        expect(@unprocessed1.map { |m| m.metadata["client"] }).to eq(["c"])
        expect(@next_in_line1).to eq(nil)

        expect(@unprocessed2.map { |m| m.metadata["client"] }).to eq(["a", "c"])
        expect(@next_in_line2.metadata["client"]).to eq("a")

        expect(@unprocessed3.map { |m| m.metadata["client"] }).to eq(["c"])
        expect(@next_in_line1).to eq(nil)

        expect(@unprocessed4.map { |m| m.metadata["client"] }).to eq(["b", "c"])
        expect(@next_in_line4.metadata["client"]).to eq("b")
      end

      it "avoids skipping uncommitted messages (scenario 5)" do
        # TODO: set up scenario with multiple inserts in a single transaction
        # CLIENT A| BEGIN...INSERT..................COMMIT
        # CLIENT B|    BEGIN...INSERT..........................................COMMIT
        # CLIENT C|       BEGIN...INSERT..COMMIT
        # CLIENT D|                            SELECT    SELECT  PROCESS  SELECT    SELECT
        client_a = Thread.new do
          ApplicationRecord.transaction do
            @a_begun = true
            new_message(metadata: {"client" => "a"}).save!
            @a_inserted = true
            sleep 0.01 until @selected1
          end
          @a_committed = true
        end
        client_b = Thread.new do
          sleep 0.01 until @a_begun
          ApplicationRecord.transaction do
            @b_begun = true
            sleep 0.01 until @a_inserted
            new_message(metadata: {"client" => "b"}).save!
            @b_inserted = true
            sleep 0.01 until @selected3
          end
          @b_committed = true
        end
        client_c = Thread.new do
          sleep 0.01 until @b_begun
          ApplicationRecord.transaction do
            sleep 0.01 until @b_inserted
            new_message(metadata: {"client" => "c"}).save!
          end
          @c_committed = true
        end
        client_d = Thread.new do
          sleep 0.01 until @c_committed
          @unprocessed1 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line1 = message.class.next_in_line(key:, processor_name:)
          @selected1 = true
          sleep 0.01 until @a_committed
          @unprocessed2 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line2 = message.class.next_in_line(key:, processor_name:)
          @selected2 = true
          @next_in_line2.processed(processor_name:)
          @unprocessed3 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line3 = message.class.next_in_line(key:, processor_name:)
          @selected3 = true
          sleep 0.01 until @b_committed
          @unprocessed4 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line4 = message.class.next_in_line(key:, processor_name:)
        end
        [client_a, client_b, client_c, client_d].each(&:join)

        expect(@unprocessed1.map { |m| m.metadata["client"] }).to eq(["c"])
        expect(@next_in_line1).to eq(nil)

        expect(@unprocessed2.map { |m| m.metadata["client"] }).to eq(["a", "c"])
        expect(@next_in_line2.metadata["client"]).to eq("a")

        expect(@unprocessed3.map { |m| m.metadata["client"] }).to eq(["c"])
        expect(@next_in_line1).to eq(nil)

        expect(@unprocessed4.map { |m| m.metadata["client"] }).to eq(["b", "c"])
        expect(@next_in_line4.metadata["client"]).to eq("b")
      end

      it "skips rolled-back messages" do
        # CLIENT A| BEGIN........INSERT..ROLLBACK
        # CLIENT B|    BEGIN....................INSERT..COMMIT
        # CLIENT C|         SELECT              SELECT       SELECT
        client_a = Thread.new do
          ApplicationRecord.transaction do
            sleep 0.01 until @selected1
            new_message(metadata: {"client" => "a"}, xid: -1).save(validate: false)
          rescue ActiveModel::RangeError
            @a_rolledback = true
          end
        end
        client_b = Thread.new do
          ApplicationRecord.transaction do
            sleep 0.01 until @a_rolledback
            new_message(metadata: {"client" => "b"}).save!
            sleep 0.01 until @selected2
          end
          @b_committed = true
        end
        client_c = Thread.new do
          @unprocessed1 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line1 = message.class.next_in_line(key:, processor_name:)
          @selected1 = true
          sleep 0.01 until @a_rolledback
          @unprocessed2 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line2 = message.class.next_in_line(key:, processor_name:)
          @selected2 = true
          sleep 0.01 until @b_committed
          @unprocessed3 = message.class.unprocessed(processor_name:).order(:id).to_a
          @next_in_line3 = message.class.next_in_line(key:, processor_name:)
        end
        [client_a, client_b, client_c].each(&:join)

        expect(@unprocessed1).to be_empty
        expect(@next_in_line1).to eq(nil)

        expect(@unprocessed2).to be_empty
        expect(@next_in_line2).to eq(nil)

        expect(@unprocessed3.map { |m| m.metadata["client"] }).to eq(["b"])
        expect(@next_in_line3.metadata["client"]).to eq("b")
      end
    end
  end
end
