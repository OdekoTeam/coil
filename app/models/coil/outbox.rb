# typed: strict

module Coil
  module Outbox
    def self.table_name_prefix
      module_parent.table_name_prefix + "outbox_"
    end
  end
end