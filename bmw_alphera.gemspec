# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bmw_alphera/version'

Gem::Specification.new do |spec|
  spec.name          = "bmw_alphera"
  spec.version       = BmwAlphera::VERSION
  spec.authors       = ["Andre Mouton"]
  spec.email         = ["andre@amtek.co.za", "info@shuntyard.co.za", "info@easylodge.com.au"]
  spec.summary       = %q{BMW Alphera.}
  spec.description   = %q{Submit applications to BMW Alphera.}
  spec.homepage      = "https://github.com/easylodge/bmw_alphera"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_dependency "nokogiri"
  spec.add_dependency 'httparty'
end
