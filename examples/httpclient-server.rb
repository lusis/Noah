#!/usr/bin/env ruby
require 'sinatra'
require 'json'
post '/webhook' do
  x = request.body.read
  puts JSON.load(x)
end
