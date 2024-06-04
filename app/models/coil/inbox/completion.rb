# typed: strict

module Coil
  module Inbox
    class Completion < ApplicationRecord
      include PreventDestruction

      attr_readonly :processor_name, :message_type, :message_key
    end
  end
end
