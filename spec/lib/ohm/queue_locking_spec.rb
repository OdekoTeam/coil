require "rails_helper"

RSpec.describe Ohm::QueueLocking do
  describe ".locking" do
    # queue types
    let(:q1) { "Q1" }
    let(:q2) { "Q2" }

    # message types
    let(:m1) { "M1" }
    let(:m2) { "M2" }

    it "prevents concurrent operations on the same queue type, message type and key" do
      vals = []

      thread1 = Thread.new do
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"]) do
          @locked = true
          vals.append(:a)
          sleep 0.1
          vals.append(:b)
        end
      end
      thread2 = Thread.new do
        sleep 0.01 until @locked
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"]) do
          vals.append(:c)
        end
      end
      [thread1, thread2].each(&:join)

      expect(vals).to eq([:a, :b, :c])
    end

    it "allows concurrent operations on different queue types" do
      vals = []

      thread1 = Thread.new do
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"]) do
          @locked = true
          vals.append(:a)
          sleep 0.1
          vals.append(:b)
        end
      end
      thread2 = Thread.new do
        sleep 0.01 until @locked
        described_class.locking(queue_type: q2, message_type: m1, message_keys: ["x"]) do
          vals.append(:c)
        end
      end
      [thread1, thread2].each(&:join)

      expect(vals).to eq([:a, :c, :b])
    end

    it "allows concurrent operations on different message types" do
      vals = []

      thread1 = Thread.new do
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"]) do
          @locked = true
          vals.append(:a)
          sleep 0.1
          vals.append(:b)
        end
      end
      thread2 = Thread.new do
        sleep 0.01 until @locked
        described_class.locking(queue_type: q1, message_type: m2, message_keys: ["x"]) do
          vals.append(:c)
        end
      end
      [thread1, thread2].each(&:join)

      expect(vals).to eq([:a, :c, :b])
    end

    it "allows concurrent operations on different message keys" do
      vals = []

      thread1 = Thread.new do
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"]) do
          @locked = true
          vals.append(:a)
          sleep 0.1
          vals.append(:b)
        end
      end
      thread2 = Thread.new do
        sleep 0.01 until @locked
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["y"]) do
          vals.append(:c)
        end
      end
      [thread1, thread2].each(&:join)

      expect(vals).to eq([:a, :c, :b])
    end

    it "works for multiple keys" do
      vals = []

      thread1 = Thread.new do
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x", "y", "w"]) do
          @locked = true
          vals.append(:a)
          sleep 0.1
          vals.append(:b)
        end
      end
      thread2 = Thread.new do
        sleep 0.01 until @locked
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["z", "x"]) do
          vals.append(:c)
        end
      end
      [thread1, thread2].each(&:join)

      expect(vals).to eq([:a, :b, :c])
    end

    it "recognizes identical complex keys" do
      key = {
        "a" => {"x" => 1, "y" => 2},
        "b" => {"x" => 3, "y" => 4}
      }
      vals = []

      thread1 = Thread.new do
        described_class.locking(queue_type: q1, message_type: m1, message_keys: [key]) do
          @locked = true
          vals.append(:a)
          sleep 0.1
          vals.append(:b)
        end
      end
      thread2 = Thread.new do
        sleep 0.01 until @locked
        described_class.locking(queue_type: q1, message_type: m1, message_keys: [key]) do
          vals.append(:c)
        end
      end
      [thread1, thread2].each(&:join)

      expect(vals).to eq([:a, :b, :c])
    end

    it "recognizes equivalent complex keys" do
      key1 = {
        "a" => {"x" => 1, "y" => {"p" => "P", "q" => "Q"}},
        "b" => {"x" => 3, "y" => 4}
      }
      key2 = {
        "b" => {"y" => 4, "x" => 3},
        a: {"y" => {q: "Q", "p" => "P"}, x: 1} # standard:disable Style/HashSyntax
      }
      vals = []

      thread1 = Thread.new do
        described_class.locking(queue_type: q1, message_type: m1, message_keys: [key1]) do
          @locked = true
          vals.append(:a)
          sleep 0.1
          vals.append(:b)
        end
      end
      thread2 = Thread.new do
        sleep 0.01 until @locked
        described_class.locking(queue_type: q1, message_type: m1, message_keys: [key2]) do
          vals.append(:c)
        end
      end
      [thread1, thread2].each(&:join)

      expect(vals).to eq([:a, :b, :c])
    end

    it "recognizes different complex keys" do
      key1 = {
        "a" => {"x" => 1, "y" => 2},
        "b" => {"x" => 3, "y" => 4}
      }
      key2 = {
        "a" => {"x" => 1, "y" => 2},
        "b" => {"x" => 3, "y" => 4, "z" => 5}
      }
      vals = []

      thread1 = Thread.new do
        described_class.locking(queue_type: q1, message_type: m1, message_keys: key1) do
          @locked = true
          vals.append(:a)
          sleep 0.1
          vals.append(:b)
        end
      end
      thread2 = Thread.new do
        sleep 0.01 until @locked
        described_class.locking(queue_type: q1, message_type: m2, message_keys: key2) do
          vals.append(:c)
        end
      end
      [thread1, thread2].each(&:join)

      expect(vals).to eq([:a, :c, :b])
    end

    it "raises LockWaitTimeout if lock cannot be acquired before timeout" do
      vals = []
      errors = {}

      thread1 = Thread.new do
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"]) do
          @locked = true
          vals.append(:a)
          sleep 0.1
          vals.append(:b)
        end
      end
      thread2 = Thread.new do
        ApplicationRecord.connection.execute("SET lock_timeout = '1ms'")
        sleep 0.01 until @locked
        described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"]) do
          vals.append(:c)
        end
      rescue Ohm::QueueLocking::LockWaitTimeout => e
        errors[:thread2] = e
      end
      [thread1, thread2].each(&:join)

      expect(errors.keys).to eq([:thread2])
      expect(errors[:thread2]).to be_a(Ohm::QueueLocking::LockWaitTimeout)

      expect(vals).to eq([:a, :b])
    end

    context "when caller doesn't want to wait" do
      it "raises LockWaitTimeout if lock cannot be acquired immediately" do
        vals = []
        errors = {}

        thread1 = Thread.new do
          described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"]) do
            @locked = true
            vals.append(:a)
            sleep 0.1
            vals.append(:b)
          end
        end
        thread2 = Thread.new do
          sleep 0.01 until @locked
          described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"], wait: false) do
            vals.append(:c)
          end
        rescue Ohm::QueueLocking::LockWaitTimeout => e
          errors[:thread2] = e
        end
        [thread1, thread2].each(&:join)

        expect(errors.keys).to eq([:thread2])
        expect(errors[:thread2]).to be_a(Ohm::QueueLocking::LockWaitTimeout)

        expect(vals).to eq([:a, :b])
      end

      it "works as normal if lock can be acquired immediately" do
        vals = []
        errors = {}

        thread1 = Thread.new do
          described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"], wait: false) do
            @locked = true
            vals.append(:a)
            sleep 0.1
            vals.append(:b)
          end
        rescue Ohm::QueueLocking::LockWaitTimeout => e
          errors[:thread1] = e
        end
        thread2 = Thread.new do
          sleep 0.01 until @locked
          described_class.locking(queue_type: q1, message_type: m1, message_keys: ["x"]) do
            vals.append(:c)
          end
        end
        [thread1, thread2].each(&:join)

        expect(errors).to be_empty
        expect(vals).to eq([:a, :b, :c])
      end
    end

    it "yields unaltered operation if keys is empty" do
      vals = []

      described_class.locking(queue_type: q1, message_type: m1, message_keys: []) do
        vals.append(:a)
      end

      expect(vals).to eq([:a])
    end
  end
end
