require 'sinatra/reloader' if development?
require 'ohm'
require 'json'
require 'haml'

require File.join(File.dirname(__FILE__), 'config/db')
require File.join(File.dirname(__FILE__), 'models')
require File.join(File.dirname(__FILE__), 'helpers')

get '/' do
  before do
    content_type "text/html"
  end

  haml :index, :format => :html5
end

before do
  content_type "application/json"
end

namespace "/h" do

  get '/:hostname/:servicename/?' do |hostname, servicename|
    host_service(hostname, servicename).to_json
  end

  get '/:hostname/?' do |hostname|
    host(:name => hostname).to_json
  end

  get '/?' do
    hosts.map {|h| h.to_hash}
    hosts.to_json
  end

  put '/?' do
    begin
      required_params = ["name", "status"]
      data = JSON.parse(request.body.read)
      data.keys.sort == required_params.sort  ? (host = Host.find_or_create(:name => data['name'], :status => data['status'])) : (raise "Missing Parameters")
      if host.valid?
        status 200
        r = {"result" => "success","id" => "#{host.id}","status" => "#{host.status}", "name" => "#{host.name}"}
        r.to_json
      else
        status 500
        r = {"result" => "failure","error" => "#{app.errors}"}
        r.to_json
      end
    rescue Exception => e
      status 500
      r = {"result" => "failure","error" => "#{e.message}"}
      r.to_json
    end
  end

  delete '/:hostname/?' do
    begin
      host = Host.find(:name => params[:hostname]).first
      if host
        services = []
        Service.find(:host_id => host.id).sort.each {|x| services << x; x.delete} if host.services.size > 0
        host.delete
        status 200
        r = {"result" => "success", "id" => "#{host.id}", "name" => "#{host.name}", "service_count" => "#{services.size}"}
        r.to_json
      else
        status 404
        r = {"result" => "failure","error" => "Host not found"}
        r.to_json
      end
    rescue Exception => e
      status 500
      r = {"result" => "failure", "error" => "#{e.message}"}
      r.to_json
    end
  end

end

namespace "/s" do

  get '/:servicename/:hostname/?' do |servicename, hostname|
    host_service(hostname, servicename).to_json
  end

  get '/:servicename/?' do |servicename|
    s = services(:name => servicename)
    s.map {|x| x.to_hash}
    s.to_json
  end

  get '/?' do
    services.map {|s| s.to_hash}
    services.to_json
  end

end

namespace "/a" do

  get '/:appname/:config/?' do
    app = Application.find(:name => params[:appname]).first
    c = Configuration.find(:name => params[:config], :application_id => app.id).first
    "#{c.to_json}"
  end

  get '/:appname/?' do
    app = Application.find(:name => params[:appname]).first
    "#{app.to_json}"
  end

  put '/:appname/?' do
    begin
      app = Application.find(:name => params[:appname]).first ||= Application.create(:name => params[:appname])
      data = JSON.parse(request.body.read)
      app.name = data['name']
      if app.valid?
        app.save
        status 200
        r = {"result" => "success","id" => "#{app.id}"}
        r.to_json
      else
        status 500
        r = {"result" => "failure","error" => "#{app.errors}"}
        r.to_json
      end
    rescue Exception => e
      status 500
      r = {"result" => "failure","error" => "#{e.message}"}
      r.to_json
    end
  end

  delete '/:appname/?' do
    begin
      app = Application.find(:name => params[:appname]).first
      if app
        Configuration.find(:application_id => app.id).sort.each {|x| x.delete} if app.configurations.size > 0
        app.delete
        status 200
        r = {"result" => "success", "id" => "#{app.id}"}
        r.to_json
      else
        status 404
        r = {"result" => "failure","error" => "Application not found"}
        r.to_json
      end
    rescue Exception => e
      status 500
      r = {"result" => "failure", "error" => "#{e.message}"}
      r.to_json
    end
  end

  get '/?' do
    apps = []
    Application.all.sort.each {|a| apps << a.to_hash}
    "#{apps.to_json}"
  end

end

namespace '/c' do

  # Need to move this out to configuration.
  # Maybe bootstrap them from itself?
  content_type_mapping = {
            :yaml => "text/x-yaml",
            :json => "application/json",
            :xml => "text/xml"
  }

  get '/:appname/:element/?' do
    a = Application.find(:name => params[:appname]).first
    c = Configuration.find(:name => params[:element], :application_id => a.id).first
    content_type content_type_mapping[c.format.to_sym] if content_type_mapping[c.format.to_sym]
    "#{c.body}"
  end

  get '/:appname/?' do
    config = []
    a = Application.find(:name => params[:appname]).first
    Configuration.find(:application_id => a.id).sort.each {|c| config << c.to_hash}
    "#{config.to_json}"
  end

  get '/?' do
    configs = []
    Configuration.all.sort.each {|c| configs << c.to_hash}
    "#{configs.to_json}"
  end

  put '/:appname/:element?' do |appname, element|
    begin
      app = Application.find_or_create(:name => appname)
      config = Configuration.find_or_create(:name => element, :application_id => app.id)
      required_params = ["format", "body"]
      data = JSON.parse(request.body.read)
      data.keys.sort == required_params.sort  ? (config.format = data["format"]; config.body = data["body"]) : (raise "Missing Parameters")
      if config.valid?
        config.save
        status 200
        r = {"result" => "success","id" => "#{config.id}"}
        r.to_json
      else
        status 500
        r = {"result" => "failure","error" => "#{config.errors}"}
        r.to_json
      end
    rescue Exception => e
      status 500
      r = {"result" => "failure","error" => "#{e.message}"}
      r.to_json
    end
  end

  delete '/:appname/:element?' do |appname, element|
    begin
      app = Application.find(:name => appname).first
      if app
        config = Configuration.find(:name=> element, :application_id => app.id).first
        if config
          config.delete
          status 200
          r = {"result" => "success", "id" => "#{config.id}", "item" => "#{appname}/#{element}"}
          r.to_json
        else
          r = {"result" => "failure","error" => "Configuration element not found"}
          halt 404, r.to_json
        end
      else
        r = {"result" => "failure","error" => "Application not found"}
        halt 404, r.to_json
      end
    rescue Exception => e
      r = {"result" => "failure", "error" => "#{e.message}"}
      halt 500, r.to_json
    end
  end

end
