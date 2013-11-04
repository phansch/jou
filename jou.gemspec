# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jou/version'

Gem::Specification.new do |spec|
  spec.name          = "jou"
  spec.version       = Jou::VERSION
  spec.authors       = ["Philipp Hansch"]
  spec.email         = ["dev@phansch.net"]
  spec.description   = %q{A simple command line utility that helps with maintaining a journal file}
  spec.summary       = %q{GTD journal utility}
  spec.homepage      = "http://rubygems.org/gems/jou"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rdoc"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "rake", "~> 0.9.2"
  spec.add_development_dependency "rspec", "~>2"
  spec.add_dependency "methadone", "~> 1.3.0"
end