require 'sinatra/reloader' if development?
require 'ohm'
require 'json'
require 'haml'

require File.join(File.dirname(__FILE__), 'config/db')
require File.join(File.dirname(__FILE__), 'models')

# Read operations
## Hosts
# Specifc Host/Specific Service
get '/h/:hostname/s/:servicename/?' do
  host = Host.find(:name => params[:hostname]).first
  service = Service.find(:name => params[:servicename], :host_id => host.id).first
  "#{service.to_json}"
end

# Specific Host/All Services
get '/h/:hostname/s/?' do
  host = Host.find(:name => params[:hostname]).first
  services = []
  Service.find(:host_id => host.id).sort.each {|s| services << s.to_hash}
  "#{services.to_json}"
end

# Specific Host
get '/h/:hostname/?' do
  host = Host.find(:name => "#{params[:hostname]}").first
  "#{host.to_json}"
end

# All Hosts
get '/h/?' do
  hosts = []
  Host.all.sort.each {|h| hosts << h.to_hash}
  "#{hosts.to_json}"
end

## Services
get '/s/:servicename/h/:hostname/?' do
  h = Host.find(:name => params[:hostname]).first.id
  s = Service.find(:name => params[:servicename], :host_id => h).first
  "#{s.to_json}"
end

get '/s/:servicename/?' do
  services = []
  Service.find(:name => "#{params[:servicename]}").sort.each {|s| services << s.to_hash}
  "#{services.to_json}"
end

get '/s/?' do
  services = []
  Service.all.sort.each {|s| services << s.to_hash}
  "#{services.to_json}"  
end

# Applications
get '/a/:appname/:config/?' do
  app = Application.find(:name => params[:appname]).first
  c = Configuration.find(:name => params[:config], :application_id => app.id).first
  "#{c.to_json}"
end

get '/a/:appname/?' do
  app = Application.find(:name => params[:appname]).first
  "#{app.to_json}"
end

put '/a/:appname/?' do
  begin
    app = Application.find(:name => params[:appname]).first ||= Application.create(:name => params[:appname])
    data = JSON.parse(request.body.read)
    app.name = data['name']
    if app.valid?
      app.save
      status 200
      content_type 'application/json'
      r = {"result" => "success","id" => "#{app.id}"}
      r.to_json
    else
      status 500
      content_type 'application/json'
      r = {"result" => "failure","error" => "#{app.errors}"}
      r.to_json
    end
  rescue Exception => e
    status 500
    content_type 'application/json'
    r = {"result" => "failure","error" => "#{e.message}"}
    r.to_json
  end
end

delete '/a/:appname/?' do
  begin
    app = Application.find(:name => params[:appname]).first
    if app
      Configuration.find(:application_id => app.id).sort.each {|x| x.delete} if app.configurations.size > 0
      app.delete
      status 200
      content_type 'application/json'
      r = {"result" => "success", "id" => "#{app.id}"}
      r.to_json
    else
      status 404
      content_type 'application/json'
      r = {"result" => "failure","error" => "Application not found"}
      r.to_json
    end
  rescue Exception => e
    status 500
    content_type 'application/json'
    r = {"result" => "failure", "error" => "#{e.message}"}
    r.to_json
  end
end

get '/a/?' do
  apps = []
  Application.all.sort.each {|a| apps << a.to_hash}
  "#{apps.to_json}"
end

## Configs
get '/c/:appname/:element/?' do
  a = Application.find(:name => params[:appname]).first
  c = Configuration.find(:name => params[:element], :application_id => a.id).first
  case c.format
    when "json"
      content_type 'application/json'
    when "xml"
      content_type 'text/xml'
    when "yaml"
      content_type 'text/x-yaml'
    else
      content_type 'text/plain'
    end
  "#{c.body}"
end

get '/c/:appname/?' do
  config = []
  a = Application.find(:name => params[:appname]).first
  Configuration.find(:application_id => a.id).sort.each {|c| config << c.to_hash}
  "#{config.to_json}"
end

get '/c/?' do
  configs = []
  Configuration.all.sort.each {|c| configs << c.to_hash}
  "#{configs.to_json}"
end

get '/' do
  haml :index, :format => :html5
end

# A route for adding a new host
put '/h/:hostname' do
  host = params[:hostname]
  data = JSON.parse(request.body.read)
  begin
    h = Host.find(:name => host).first
    h.state = 1
  rescue
    # If we have to register the host, we mark it as inactive
    # Feels like the right thing to do in case of accidental creation
    # from mispelling
    h = Host.create(:name => params[:hostname], :state => 0)
  end
  if h.save
    data['services'].each {|x| h.services << Service.create(:name=> x['name'], :state => x['state'], :host => h)} if data['services']
    {"msg" => "success"}.to_json
  end
end
