# typed: strict

module Ohm
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
