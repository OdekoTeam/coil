# typed: strict

module Coil
  module Inbox
    def self.table_name_prefix
      module_parent.table_name_prefix + "inbox_"
    end
  end
end
