# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fragile/version'

Gem::Specification.new do |gem|
  gem.name          = "fragile"
  gem.version       = Fragile::VERSION
  gem.authors       = ["tnakamura"]
  gem.email         = ["griefworker@gmail.com"]
  gem.description   = %q{Ruby Pipeline Framework}
  gem.summary       = %q{Ruby Pipeline Framework}
  gem.homepage      = "https://github.com/tnakamura/fragile"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
end
