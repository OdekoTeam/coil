require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative 'dummy/config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Checks for pending migrations and applies them before tests are run.
begin
  # ActiveRecord::Migrator.migrations_paths = [Rails.root.join("db/migrate").to_s]
  engine_root = File.join(File.dirname(__FILE__), "../")
  ActiveRecord::Migrator.migrations_paths = File.join(engine_root, "spec/dummy/db/migrate")
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
