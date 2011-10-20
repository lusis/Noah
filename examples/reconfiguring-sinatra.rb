#!/usr/bin/env ruby
require 'sinatra'
require 'ohm'
require 'open-uri'
require 'json'

set :noah_server, 'http://localhost:5678'
set :noah_client_name, 'my_sinatra_app'

def get_config_from_noah(setting)
  begin
    c = open("#{settings.noah_server}/applications/#{settings.noah_client_name}/configurations/#{setting}").read
    set setting.to_sym, c
  end
end

get_config_from_noah('redis_server')

def get_redis_version
  Ohm.connect :url => settings.redis_server['body']
  Ohm.redis.info["redis_version"]
end

get "/" do
  "Redis version: #{get_redis_version}"
end

post "/webhook" do
  data = JSON.parse(request.body.read)
  settings.redis_server = data
  puts data["body"]
  resp = {:message => "reconfigured", :setting => data["name"], :body => data["body"]}.to_json
  "#{resp}"
end
