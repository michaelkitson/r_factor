# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'r_factor/version'

Gem::Specification.new do |spec|
  spec.name          = 'r_factor'
  spec.version       = RFactor::VERSION
  spec.authors       = ['Michael Kitson']
  spec.email         = ['michaelskitson@gmail.com']

  spec.summary       = %q{A small CLI utility to factor integers}
  spec.homepage      = 'https://github.com/michaelkitson/r_factor'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = ['factor']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
