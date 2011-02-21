begin
  require 'yajl'
rescue LoadError
  require 'json'
end
require 'haml'
require 'yaml'
require 'sinatra/base'
require 'sinatra/namespace'

require File.join(File.dirname(__FILE__), 'noah','models')
require File.join(File.dirname(__FILE__), 'noah','app')
