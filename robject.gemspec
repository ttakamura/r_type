# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'robject/version'

Gem::Specification.new do |spec|
  spec.name          = "robject"
  spec.version       = RObject::VERSION
  spec.authors       = ["Tatsuya Takamura"]
  spec.email         = ["tkmr2000@gmail.com"]
  spec.description   = %q{RObject is a wrapper library for RSRuby.}
  spec.summary       = %q{RObject is a wrapper library for RSRuby.}
  spec.homepage      = "https://github.com/ttakamura"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rsruby", ">= 0.5"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13.0"
end
