# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Coil::TransactionalMessagesPeriodicJob`.
# Please instead update this file by running `bin/tapioca dsl Coil::TransactionalMessagesPeriodicJob`.


class Coil::TransactionalMessagesPeriodicJob
  class << self
    sig { returns(String) }
    def perform_async; end

    sig { params(interval: T.any(DateTime, Time)).returns(String) }
    def perform_at(interval); end

    sig { params(interval: Numeric).returns(String) }
    def perform_in(interval); end
  end
end
