# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "noah/version"

Gem::Specification.new do |s|
  s.name        = "noah"
  s.version     = Noah::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["lusis"]
  s.email       = ["lusis.org+rubygems.org@gmail.com"]
  s.homepage    = "https://github.com/lusis/noah"
  s.summary     = %q{Application registry based on Apache Zookeeper}
  s.description = %q{Application registry based on Apache Zookeeper}

  s.rubyforge_project = "noah"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
