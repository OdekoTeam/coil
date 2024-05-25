# This periodic job acts as a fallback mechanism, polling for outbox messages
# that were not enqueued and processed automatically upon create, e.g. due to a
# failure to push a job onto the Redis queue.
module Ohm
  module Outbox
    class MessagesPeriodicJob < TransactionalMessagesPeriodicJob
      private

      def message_parent_class
        ::Ohm::Outbox::Message
      end
    end
  end
end
