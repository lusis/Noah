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

  get '/:hostname/s/:servicename/?' do |hostname, servicename|
    host_service(hostname, servicename).to_json
  end

  get '/:hostname/s/?' do |hostname|
    hs = host_services(hostname)
    hs.map! {|x| x.to_hash} 
    hs.to_json
  end

  get '/:hostname/?' do |hostname|
    host(:name => hostname).to_json
  end

  get '/?' do
    hosts.map {|h| h.to_hash}
    hosts.to_json
  end

end

namespace "/s" do

  get '/:servicename/h/:hostname/?' do |servicename, hostname|
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

  put '/:appname/:element?' do |appname, item|
    begin
      app = Application.find_or_create(:name => appname)
      config = Configuration.find_or_create(:name => item, :application_id => app.id)
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
