require 'sinatra/base'
require 'sinatra/namespace'
require 'ohm'
require 'ohm/contrib'

require File.join(File.dirname(__FILE__), 'helpers')
require File.join(File.dirname(__FILE__), 'models')

module Noah
  class App < Sinatra::Base
    register ::Sinatra::Namespace

    helpers Noah::SinatraHelpers

    configure do
      set :app_file, __FILE__
      set :root, File.expand_path(File.join(File.dirname(__FILE__), "..",".."))
      set :server, %w[thin mongrel webrick]
      set :logging, true
      set :raise_errors, false
      set :show_exceptions, false
      set :run, false
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

    before do
      content_type "application/json"
    end

    get '/' do
      content_type "text/html"

      haml :index, :format => :html5
    end

    not_found do
      content_type "application/json"
      erb :'404'
    end

    error do
      content_type "application/json"
      erb :'500'
    end

    # Placeholder for admin functions
    namespace "/ark" do
    end

    # Placeholder for watchers
    namespace "/w" do
    end

    namespace "/h" do

      get '/:hostname/:servicename/?' do |hostname, servicename|
        h = host_service(hostname, servicename)
        if h.nil?
          halt 404
        else
          h.to_json
        end
      end

      get '/:hostname/?' do |hostname|
        h = host(:name => hostname)
        if h.nil?
          halt 404
        else
          h.to_json
        end
      end

      get '/?' do
        hosts.map {|h| h.to_hash}
        if hosts.size == 0
          halt 404
        else
          hosts.to_json
        end
      end

      put '/:hostname/?' do |hostname|
        required_params = ["name", "status"]
        data = JSON.parse(request.body.read)
        (data.keys.sort == required_params.sort && data['name'] == hostname) ? (host = ::Host.find_or_create(:name => data['name'], :status => data['status'])) : (raise "Missing Parameters")
        if host.valid?
          r = {"result" => "success","id" => "#{host.id}","status" => "#{host.status}", "name" => "#{host.name}", "new_record" => host.is_new?}
          r.to_json
        else
          raise "#{host.errors}"
        end
      end

      delete '/:hostname/?' do |hostname|
        host = ::Host.find(:name => hostname).first
        if host
          services = []
          Service.find(:host_id => host.id).sort.each {|x| services << x; x.delete} if host.services.size > 0
          host.delete
          r = {"result" => "success", "id" => "#{host.id}", "name" => "#{hostname}", "service_count" => "#{services.size}"}
          r.to_json
        else
          halt 404
        end
      end

    end

    namespace "/s" do

      get '/:servicename/:hostname/?' do |servicename, hostname|
        hs = host_service(hostname, servicename)
        if hs.nil?
          halt 404
        else  
          hs.to_json
        end  
      end

      get '/:servicename/?' do |servicename|
        s = services(:name => servicename)
        s.map {|x| x.to_hash}
        if s.empty?
          halt 404
        else  
          s.to_json
        end  
      end

      get '/?' do
        if services.empty?
          halt 404
        else
          services.map {|s| s.to_hash}
          services.to_json
        end  
      end

      put '/:servicename/?' do |servicename|
        required_params = ["status", "host", "name"]
        data = JSON.parse(request.body.read)
        if data.keys.sort == required_params.sort
          h = ::Host.find(:name => data['host']).first || (raise "Invalid Host")
          service = ::Service.find_or_create(:name => servicename, :status => data['status'], :host => h)
          if service.valid?
            action = service.is_new? ? "create" : "update"
            service.save
            r = {"action" => action, "result" => "success", "id" => service.id, "host" => h.name, "name" => service.name}
            r.to_json
          else
            raise "#{service.errors}"
          end
        else
          raise "Missing Parameters"
        end  
      end

      delete '/:servicename/:hostname/?' do |servicename, hostname|
        host = ::Host.find(:name => hostname).first || (halt 404)
        service = ::Service.find(:name => servicename, :host_id => host.id).first || (halt 404)
        if host && service
          service.delete
          r = {"action" => "delete", "result" => "success", "id" => service.id, "host" => host.name, "service" => servicename}
          r.to_json
        else
          halt 404
        end  
      end  

    end

    namespace "/a" do

      get '/:appname/:config/?' do |appname, config|
        app = ::Application.find(:name => appname).first
        if app.nil?
          halt 404
        else  
          c = ::Configuration.find(:name => config, :application_id => app.id).first
          c.to_json
        end  
      end

      get '/:appname/?' do |appname|
        app = ::Application.find(:name => appname).first
        if app.nil?
          halt 404
        else
          app.to_json
        end
      end

      put '/:appname/?' do |appname|
        required_params = ["name"]
        data = JSON.parse(request.body.read)
        if data.keys.sort == required_params.sort && data['name'] == appname
          app = ::Application.find_or_create(:name => appname)
        else
          raise "Missing Parameters"
        end  
        if app.valid?
          action = app.is_new? ? "create" : "update"
          app.save
          r = {"result" => "success","id" => app.id, "action" => action, "name" => app.name }
          r.to_json
        else
          raise "#{app.errors}"
        end
      end

      delete '/:appname/?' do |appname|
        app = ::Application.find(:name => appname).first
        if app.nil?
          halt 404
        else
          configurations = []
          ::Configuration.find(:application_id => app.id).sort.each {|x| configurations << x; x.delete} if app.configurations.size > 0
          app.delete
          r = {"result" => "success", "action" => "delete", "id" => "#{app.id}", "name" => "#{appname}", "configurations" => "#{configurations.size}"}
          r.to_json
        end
      end

      get '/?' do
        apps = []
        ::Application.all.sort.each {|a| apps << a.to_hash}
        if apps.empty?
          halt 404
        else  
          apps.to_json
        end  
      end

    end

    namespace '/c' do

      # Need to move this out to configuration.
      # Maybe bootstrap them from itself?
      content_type_mapping = {
                :yaml => "text/x-yaml",
                :json => "application/json",
                :xml => "text/xml",
                :string => "text/plain"
      }

      get '/:appname/:element/?' do |appname, element|
        a = ::Application.find(:name => appname).first
        if a.nil?
          halt 404
        else  
          c = ::Configuration.find(:name => element, :application_id => a.id).first
          content_type content_type_mapping[c.format.to_sym] if content_type_mapping[c.format.to_sym]
          c.body
        end  
      end

      get '/:appname/?' do |appname|
        config = []
        a = ::Application.find(:name => appname).first
        if a.nil?
          halt 404
        else  
          ::Configuration.find(:application_id => a.id).sort.each {|c| config << c.to_hash}
          config.to_json
        end  
      end

      get '/?' do
        configs = []
        ::Configuration.all.sort.each {|c| configs << c.to_hash}
        if configs.empty?
          halt 404
        else  
          configs.to_json
        end  
      end

      put '/:appname/:element?' do |appname, element|
        app = ::Application.find_or_create(:name => appname)
        config = ::Configuration.find_or_create(:name => element, :application_id => app.id)
        required_params = ["format", "body"]
        data = JSON.parse(request.body.read)
        data.keys.sort == required_params.sort  ? (config.format = data["format"]; config.body = data["body"]) : (raise "Missing Parameters")
        if config.valid?
          config.save
          action = config.is_new? ? "create" : "update"
          dependency_action = app.is_new? ? "created" : "updated"
          r = {"result" => "success","id" => "#{config.id}", "action" => action, "dependencies" => dependency_action, "application" => app.name, "item" => config.name}
          r.to_json
        else
          raise "#{config.errors}"
        end
      end

      delete '/:appname/:element?' do |appname, element|
        app = ::Application.find(:name => appname).first
        if app
          config = ::Configuration.find(:name=> element, :application_id => app.id).first
          if config
            config.delete
            r = {"result" => "success", "id" => "#{config.id}", "action" => "delete", "application" => "#{app.name}", "item" => "#{element}"}
            r.to_json
          else
            halt 404
          end
        else
          halt 404
        end
      end

    end
  #  run! if app_file == $0
  end
end
