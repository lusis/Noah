require 'rubygems'
require File.join('.', 'lib','noah')
## Uncomment the following to hardcode a redis url
ENV['REDIS_URL'] = "redis://localhost:6379/0"
noah = Noah::App.new
run noah
