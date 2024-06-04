# typed: strict

# This periodic job acts as a fallback mechanism, polling for outbox messages
# that were not enqueued and processed automatically upon create, e.g. due to a
# failure to push a job onto the Redis queue.
module Coil
  module Outbox
    class MessagesPeriodicJob < TransactionalMessagesPeriodicJob
      private

      def message_parent_class
        ::Coil::Outbox::Message
      end
    end
  end
end
