# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "em-hiredis/version"

Gem::Specification.new do |s|
  s.name        = "em-hiredis"
  s.version     = EM::Hiredis::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Martyn Loughran"]
  s.email       = ["me@mloughran.com"]
  s.homepage    = "http://github.com/mloughran/em-hiredis"
  s.summary     = %q{Eventmachine redis client}
  s.description = %q{Eventmachine redis client using hiredis native parser}

  s.add_dependency 'hiredis', '~> 0.2.0'

  s.rubyforge_project = "em-hiredis"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
