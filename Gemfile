source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in coil.gemspec.
gemspec

gem "rspec-sidekiq", group: :test
gem "database_cleaner-active_record", "~> 2.2", group: :test

# Don't automatically require tapioca. It's only needed when generating RBI files.
gem "tapioca", "~> 0.17", require: false, group: [:development, :test]

# Don't automatically require rubocop-sorbet. It's only needed when linting.
gem "rubocop-sorbet", "~> 0.9", require: false, group: [:development, :test]
