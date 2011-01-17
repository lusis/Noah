require 'sinatra/reloader' if development?
require 'ohm'
require 'json'

require File.join(File.dirname(__FILE__), 'config/db')
require File.join(File.dirname(__FILE__), 'models')

# Read operations
## Hosts
### Still not sold on this pathing structure
get '/h/:hostname/s/:servicename/?' do
  host = Host.find(:name => params[:hostname]).first
  service = Service.find(:name => params[:servicename], :host_id => host.id).first
  "#{service.to_json}"
end

get '/h/:hostname/s/?' do
  host = Host.find(:name => params[:hostname]).first
  services = []
  Service.find(:host_id => host.id).sort.each {|s| services << s.to_hash}
  "#{services.to_json}"
end


get '/h/:hostname/?' do
  host = Host.find(:name => "#{params[:hostname]}").first
  "#{host.to_json}"
end

# Catchall
get '/h/?' do
  hosts = []
  Host.all.sort.each {|h| hosts << h.to_hash}
  "#{hosts.to_json}"
end

## Services
get '/s/:servicename/h/:hostname/?' do
  s = Service.find(:name => "#{params[:servicename]}").first
  h = Host.find(:name => "#{params[:hostname]}", :service_id => s.id).first
  "#{h.to_json}"
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

get '/a/?' do
  apps = []
  Application.all.sort.each {|a| apps << a.to_hash}
  "#{apps.to_json}"
end

## Configs
get '/c/:appname/:element/?' do
  a = Application.find(:name => params[:appname]).first
  c = Configuration.find(:name => params[:element], :application_id => a.id).first
  "#{c.to_json}"
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
