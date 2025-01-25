# typed: strict

# This job deletes processed inbox messages whose retention period has passed.
module Coil
  module Inbox
    class MessagesCleanupJob < TransactionalMessagesCleanupJob
      private

      def message_parent_class
        ::Coil::Inbox::Message
      end

      def retention_period
        ::Coil.inbox_retention_period
      end
    end
  end
end
