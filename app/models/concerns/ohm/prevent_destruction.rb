# typed: false

module Ohm
  module PreventDestruction
    extend ActiveSupport::Concern

    included do
      unless self < ActiveRecord::Base
        raise <<~ERR.squish
          Cannot include PreventDestruction in #{self} because #{self} does not
          inherit from ActiveRecord::Base.
        ERR
      end

      before_destroy :prevent_destruction, prepend: true
    end

    private

    def prevent_destruction
      throw(:abort)
    end
  end
end
