lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sjc_bus_schedule/version"

Gem::Specification.new do |spec|
  spec.name          = "sjc_bus_schedule"
  spec.version       = SJCBusSchedule::VERSION
  spec.authors       = ["Matheus Silva Santos de Oliveira"]
  spec.email         = ["oliveira.matheussilvasantos@gmail.com"]

  spec.summary       = %q{Extract bus schedule from SJC website}
  spec.description   = %q{Makes life easy for who wants to get the bus schedule from SJC website}
  spec.homepage      = "https://github.com/matheussilvasantos/sjc_bus_schedule"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/matheussilvasantos/sjc_bus_schedule"
  spec.metadata["changelog_uri"] = "https://github.com/matheussilvasantos/sjc_bus_schedule/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 5.0.0"
  spec.add_development_dependency "webmock", "~> 3.6.0"
  spec.add_development_dependency "byebug", "~> 11.0.1"

  spec.add_dependency "httparty", "~> 0.17.0"
  spec.add_dependency "nokogiri", "~> 1.10.3"
end
