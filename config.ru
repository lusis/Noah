require 'rubygems'
require 'sinatra'
require File.join(File.dirname(__FILE__), 'lib','noah')
ENV['REDIS_URL'] = "redis://localhost:6379/0"
noah = Noah::App.new do
  set :run, false
  set :environment, :production
  set :server, %w[thin mongrel webrick Jetty Kirk]
end  
run noah
