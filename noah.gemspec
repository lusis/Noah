# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "noah/version"

Gem::Specification.new do |s|
  s.name        = "noah"
  s.version     = "#{Noah::VERSION}"
  s.post_install_message = %q{This release has backwards incompatible changes to the API. Please watch http://goo.gl/jYqp2 for details}
  s.platform    = Gem::Platform::RUBY
  #s.platform    = "jruby"
  s.authors     = ["John E. Vincent"]
  s.email       = ["lusis.org+rubygems.org@gmail.com"]
  s.homepage    = "https://github.com/lusis/noah"
  s.summary     = %q{Application registry inspired by Apache Zookeeper}
  s.description = %q{Application registry inspired by Apache Zookeeper}

  s.rubyforge_project = "noah"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("eventmachine", ["> 1.0.0.beta.3"])
  s.add_dependency("em-http-request", ["1.0.0.beta.4"])
  s.add_dependency("redis", ["= 2.2.0"])
  s.add_dependency("nest", "= 1.1.0")
  s.add_dependency("rack", "= 1.3.4")
  s.add_dependency("tilt", "= 1.3.3")
  s.add_dependency("sinatra", "= 1.3.1")
  s.add_dependency("rack-protection", "= 1.1.4")
  #s.add_dependency("rack", ["= 1.2.2"])
  #s.add_dependency("tilt", ["= 1.2.2"])
  #s.add_dependency("sinatra", ["= 1.2.3"])
  s.add_dependency("ohm", ["= 0.1.3"])
  s.add_dependency("ohm-contrib", ["= 0.1.1"])
  s.add_dependency("haml", ["= 3.0.25"])
  s.add_dependency("vegas", ["= 0.1.8"])
  s.add_dependency("guid", ["= 0.1.1"])
  s.add_dependency("slop", ["= 2.1.0"])

  s.add_dependency 'em-hiredis',                      '~> 0.1.0'
  s.add_dependency 'em-http-request',                 '~> 1.0.0.beta.4'

  if RUBY_PLATFORM =~ /java/
    s.add_dependency("jruby-openssl")
    s.add_dependency("json")
    s.add_development_dependency("warbler", ["= 1.2.1"])
  else
    s.add_dependency("hiredis", ["= 0.3.1"])
    s.add_dependency("yajl-ruby") 
    s.add_dependency("SystemTimer") if RUBY_VERSION =~ /1.8/
    s.add_dependency("thin")
  end

  s.add_development_dependency("diff-lcs", ["= 1.1.2"])
  s.add_development_dependency("sinatra-reloader", ["= 0.5.0"])
  s.add_development_dependency("rspec", ["~> 2.5"])
#  s.add_development_dependency("rcov", ["= 0.9.9"])
  s.add_development_dependency("rack-test", "= 0.6.1")
#  s.add_development_dependency("rack-test", ["= 0.5.7"])
  s.add_development_dependency("rake", ["= 0.8.7"])
end
