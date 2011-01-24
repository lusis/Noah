require "bundler/setup"

require 'ohm'
begin
  require 'yajl'
rescue LoadError
  require 'json'
end

require File.join(File.dirname(__FILE__), 'config/db')
require File.join(File.dirname(__FILE__), 'models')

