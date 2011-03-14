#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..','lib','noah','custom_watcher')
require 'em-http-request'


class HttpPostWatch < Noah::CustomWatcher
  redis_host "redis://127.0.0.1:6379/0"
  pattern "//noah/configuration"
  destination Proc.new {|x| ::EM::HttpRequest.new('http://localhost:4567/webhook', :connection_timeout => 2, :inactivity_timeout => 4).post :body => x}
  run!
end
