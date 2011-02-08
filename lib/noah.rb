require 'ohm'
require 'ohm/contrib'
begin
  require 'yajl'
rescue LoadError
  require 'json'
end
require 'haml'
require 'yaml'
require 'sinatra/base'
require 'sinatra/namespace'

require File.join(File.dirname(__FILE__), 'noah','hosts')
require File.join(File.dirname(__FILE__), 'noah','services')
require File.join(File.dirname(__FILE__), 'noah','applications')
require File.join(File.dirname(__FILE__), 'noah','configurations')
require File.join(File.dirname(__FILE__), 'noah','watchers')
require File.join(File.dirname(__FILE__), 'noah','app')
