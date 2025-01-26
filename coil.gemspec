require_relative "lib/coil/version"

Gem::Specification.new do |spec|
  spec.name = "coil"
  spec.version = Coil::VERSION
  spec.authors = ["Ivan Brennan", "Odeko Developers"]
  spec.summary = "Transactional inbox/outbox"
  spec.description = "Transactional inbox/outbox, as a Rails engine."
  spec.homepage = "https://github.com/OdekoTeam/coil"
  spec.license = "Apache-2.0"
  spec.required_ruby_version = ">= 3.1.0"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib,rbi}/**/*", "CHANGELOG.md", "LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency("rails", ">= 6.0.6", "< 8.0")
  spec.add_dependency("sidekiq", ">= 5.2", "< 8.0")
  spec.add_dependency("pg", ">= 0", "< 2.0")

  spec.add_development_dependency("rails", ">= 6.0.6", "< 8.0")
  spec.add_development_dependency("sidekiq", ">= 5.2", "< 8.0")
  spec.add_development_dependency("pg", ">= 0", "< 2.0")
  spec.add_development_dependency("puma", "~> 6.0")
  spec.add_development_dependency("rspec-rails", "~> 6.1")
  spec.add_development_dependency("standard", "~> 1.36")
  spec.add_development_dependency("rubocop-sorbet", "~> 0.8")
  spec.add_development_dependency("debug", "~> 1.0")
  spec.add_development_dependency("sorbet", "~> 0.5")
  spec.add_development_dependency("tapioca", "~> 0.14")
  spec.add_development_dependency("parlour", "~> 8.1")
end
