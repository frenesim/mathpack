# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mathpack/version"

Gem::Specification.new do |spec|
  spec.name          = "mathpack"
  spec.version       = Mathpack::VERSION
  spec.authors       = ["maxmilan"]
  spec.email         = ["max231194@gmail.com"]
  spec.summary       = "Summary"
  spec.description   = "Includes collection of mathematical methods"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/$}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/$})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
