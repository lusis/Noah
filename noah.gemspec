# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "noah/version"

Gem::Specification.new do |s|
  s.name        = "noah"
  s.version     = Noah::VERSION
  s.platform    = RUBY_ENGINE
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

  s.add_dependency("rake", ["= 0.8.7"])
  s.add_dependency("sinatra", ["= 1.1.2"])
  s.add_dependency("sinatra-namespace", ["0.6.1"])
  s.add_dependency("ohm", ["= 0.1.3"])
  s.add_dependency("ohm-contrib", ["= 0.1.0"])
  s.add_dependency("haml", ["= 3.0.25"])
  s.add_dependency("vegas", ["= 0.1.8"])
  s.add_dependency("yajl-ruby", ["= 0.7.9"]) if s.platform.to_s == 'ruby'
  s.add_dependency("jruby-json", ["= 1.5.0"]) if s.platform.to_s == 'jruby'
  s.add_dependency("thin", ["= 1.2.7"]) if s.platform.to_s == 'ruby'
  s.add_dependency("json-jruby", ["= 1.4.6"]) if s.platform.to_s == 'jruby'
  s.add_dependency("jruby-openssl", ["= 0.7.3"]) if s.platform.to_s == 'jruby'

  s.add_development_dependency("sinatra-reloader", ["= 0.5.0"])
  s.add_development_dependency("rspec", ["= 2.4.0"])
  s.add_development_dependency("rcov", ["= 0.9.9"]) if s.platform.to_s == 'ruby'
  s.add_development_dependency("rack-test", ["= 0.5.7"])
  s.add_development_dependency("ZenTest", ["= 4.4.2"])
  s.add_development_dependency("autotest", ["= 4.4.6"])
  s.add_development_dependency("autotest-growl", ["= 0.2.9"])
  s.add_development_dependency("warbler", ["= 1.2.1"]) if s.platform.to_s == 'java'

end
