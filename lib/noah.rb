require 'sinatra/base'
require 'sinatra/namespace'
require 'ohm'
require 'ohm/contrib'
begin
  require 'yajl'
rescue LoadError
  require 'json'
end
require 'haml'
require 'yaml'

require 'noah/config'
require 'noah/helpers'
require 'noah/models'

require 'noah/app'
