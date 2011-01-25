require 'bundler/setup'
require 'ohm'
begin
  require 'yajl'
rescue LoadError
  require 'json'
end  
require File.join(File.dirname(__FILE__), '..', 'config','db')
require File.join(File.dirname(__FILE__), '..', 'lib', 'models')
require File.join(File.dirname(__FILE__), '..', 'noah')
require 'rspec'
require 'rack/test'

RSpec.configure do |config|
  config.before(:each, :reset_redis => true) { Ohm::redis.flushdb }
  config.include Rack::Test::Methods
end

def app
  NoahApp
end
