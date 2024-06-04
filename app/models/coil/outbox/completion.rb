# typed: strict

module Coil
  module Outbox
    class Completion < ApplicationRecord
      include PreventDestruction

      attr_readonly :processor_name, :message_type, :message_key
    end
  end
end
