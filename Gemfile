source "http://rubygems.org"
gem "sinatra", "= 1.1.2"
gem "sinatra-namespace", "= 0.6.1"
gem "ohm", "= 0.1.3"
gem "ohm-contrib", "= 0.1.0"
gem "haml", "= 3.0.25"
gem "rake", "= 0.8.7"
group :development do
  gem "sinatra-reloader", "= 0.5.0"
  gem "rspec", "= 2.4.0"
  gem "rcov", "= 0.9.9"
  gem "rack-test", "= 0.5.7", :require => "rack/test"
end
platforms :mri do
  gem "yajl-ruby", "= 0.7.9", :require => "yajl"
end
platforms :jruby do
  gem "json-jruby", "= 1.4.6", :require => "json"
#  gem "kirk", :git => "git://github.com/strobecorp/kirk.git"
  gem "warbler", "= 1.2.1"
  gem "jruby-openssl", "= 0.7.3"
end
