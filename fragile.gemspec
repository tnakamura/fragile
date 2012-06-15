# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fragile/version"

Gem::Specification.new do |s|
  s.name        = "fragile"
  s.version     = Fragile::VERSION
  s.authors     = ["tnakamura"]
  s.email       = ["griefworker@gmail.com"]
  s.homepage    = "https://github.com/tnakamura/fragile"
  s.summary     = %q{Ruby Pipeline Framework}
  s.description = %q{Ruby Pipeline Framework}

  s.rubyforge_project = "fragile"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
