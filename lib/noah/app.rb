require File.join(File.dirname(__FILE__), 'version')
require File.join(File.dirname(__FILE__), 'helpers')
require File.join(File.dirname(__FILE__), 'models')

module Noah
  class App < Sinatra::Base
    helpers Noah::SinatraBaseHelpers

    configure do
      set :app_file, __FILE__
      set :root, File.expand_path(File.join(File.dirname(__FILE__), "..",".."))
      set :server, %w[thin mongrel webrick]
      set :logging, true
      set :raise_errors, false
      set :show_exceptions, false
      set :run, false
      set :redis_url, ENV['REDIS_URL'] || 'redis://localhost:6379/0'
    end

    configure(:development) do
      begin
        require 'sinatra/reloader'
        register Sinatra::Reloader
        also_reload File.join(File.dirname(__FILE__), 'models.rb')
        also_reload File.join(File.dirname(__FILE__), 'helpers.rb')
      rescue LoadError
        puts "sinatra-reloader gem missing. reloading disabled"
      end
    end

    # Need to move this out to configuration.
    # Maybe bootstrap them from itself?
    @content_type_mapping = {
              :yaml => "text/x-yaml",
              :json => "application/json",
              :xml => "text/xml",
              :string => "text/plain"
    }

    before do
      content_type "application/json"
    end

    # Displays an overview page of all registered objects
    get '/' do
      content_type "text/html"

      haml :index, :format => :html5, :locals => {:redis_version => Ohm.redis.info["redis_version"].to_s, :noah_version => Noah::VERSION}
    end

    not_found do
      content_type "application/json"
      erb :'404'
    end

    error do
      content_type "application/json"
      erb :'500'
    end

    load File.join(File.dirname(__FILE__), 'routes/tags.rb')
    load File.join(File.dirname(__FILE__), 'routes/hosts.rb')
    load File.join(File.dirname(__FILE__), 'routes/services.rb')
    load File.join(File.dirname(__FILE__), 'routes/applications.rb')
    load File.join(File.dirname(__FILE__), 'routes/configurations.rb')
    load File.join(File.dirname(__FILE__), 'routes/watchers.rb')
    load File.join(File.dirname(__FILE__), 'routes/ephemerals.rb')
    load File.join(File.dirname(__FILE__), 'routes/links.rb')

  end
end
