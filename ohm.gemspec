require_relative "lib/ohm/version"

Gem::Specification.new do |spec|
  spec.name = "ohm"
  spec.version = Ohm::VERSION
  spec.authors = ["Odeko"]
  spec.summary = "Transactional inbox/outbox"
  spec.description = "Transactional inbox/outbox"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib,rbi}/**/*", "Rakefile", "README.md"]
  end

  spec.add_dependency("rails", ">= 6.1.7")
  spec.add_dependency("sidekiq", ">= 5.2")
  spec.add_dependency("pg")

  spec.add_development_dependency("rails", ">= 6.1.7")
  spec.add_development_dependency("sidekiq", ">= 5.2")
  spec.add_development_dependency("pg")
  spec.add_development_dependency("puma")
  spec.add_development_dependency("rspec-rails")
  spec.add_development_dependency("standard")
  spec.add_development_dependency("debug", ">= 1.0.0")
  spec.add_development_dependency("sorbet", "~> 0.5")
  spec.add_development_dependency("tapioca", "~> 0.14")
  spec.add_development_dependency("parlour", "~> 8.1")
end
