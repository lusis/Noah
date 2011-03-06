#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..','lib','noah','watcher')
require 'excon'


class HttpPostWatch < Noah::Watcher
  redis_host "redis://127.0.0.1:6379/0"
  pattern "//noah/configuration"
  destination Proc.new {|x| ::Excon.post("http://localhost:4567/webhook", :headers => {"Content-Type" => "application/json"}, :body => x)}
  run!
end
