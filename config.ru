require 'rubygems'
require 'sinatra'
require File.join('.', 'lib','noah')
## Uncomment the following to hardcode a redis url
#ENV['REDIS_URL'] = "redis://localhost:6379/0"
noah = Noah::App.new do
  set :run, false
  set :environment, :production
## Set your server list up here
#  set :server, %w[thin mongrel webrick Jetty Kirk]
end  
run noah
