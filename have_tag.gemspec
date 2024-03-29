# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "have_tag/version"

Gem::Specification.new do |s|
  s.name        = "have_tag"
  s.version     = HaveTag::VERSION
  s.authors     = ["Dmitriy Kalinin"]
  s.email       = ["cppforlife@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "have_tag"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "active_support"

  s.add_development_dependency "rspec"
end
