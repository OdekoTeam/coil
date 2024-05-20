require_relative "lib/ohm/version"

Gem::Specification.new do |spec|
  spec.name        = "ohm"
  spec.version     = Ohm::VERSION
  spec.authors     = ["Odeko"]
  spec.summary     = "Transactional inbox/outbox"
  spec.description = "Transactional inbox/outbox"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]
  end

  spec.add_dependency("rails", ">= 6.1.7")
  spec.add_dependency("pg")
end
