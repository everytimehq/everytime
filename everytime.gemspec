# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'everytime/version'

Gem::Specification.new do |spec|
  spec.name          = "everytime"
  spec.version       = Everytime::VERSION
  spec.authors       = ["Everytime"]
  spec.email         = ["admin@everytimehq.com"]
  spec.summary       = %q{Everytime Api Wrapper}
  spec.description   = %q{Everytime Api Wrapper}
  spec.homepage      = "https://www.everytimehq.com/api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", '~> 10.3'
  spec.add_development_dependency "minitest", '~> 5.3'

  spec.add_dependency  'activeresource', '~> 4.0'
end
