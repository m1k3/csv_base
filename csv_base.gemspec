# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_base/version'

Gem::Specification.new do |spec|
  spec.name          = "csv_base"
  spec.version       = CsvBase::VERSION
  spec.authors       = ["Michal Olah"]
  spec.email         = ["olahmichal@gmail.com"]
  spec.summary       = %q{All your csv exports are belong to us}
  spec.description   = %q{A few utility modules that help with exporting csv using Postgresql}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake", ">= 12.3.3"
end
