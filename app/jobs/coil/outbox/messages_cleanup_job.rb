# typed: strict

# This job deletes processed outbox messages whose retention period has passed.
module Coil
  module Outbox
    class MessagesCleanupJob < TransactionalMessagesCleanupJob
      private

      def message_parent_class
        ::Coil::Outbox::Message
      end

      def retention_period
        ::Coil.outbox_retention_period
      end
    end
  end
end
