# typed: strict

# This periodic job acts as a fallback mechanism, polling for inbox messages
# that were not enqueued and processed automatically upon create, e.g. due to a
# failure to push a job onto the Redis queue.
module Coil
  module Inbox
    class MessagesPeriodicJob < TransactionalMessagesPeriodicJob
      private

      def message_parent_class
        ::Coil::Inbox::Message
      end
    end
  end
end
