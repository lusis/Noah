#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'rubygems'
require 'em-hiredis'
require 'em-http-request'

EventMachine.run do

  # Passing messages...like a boss
  @channel = EventMachine::Channel.new

  r = EventMachine::Hiredis::Client.connect
  r.psubscribe("noah.*")
  r.on(:pmessage) do |pattern, event, message|
    puts "Got message for #{event}"
    @channel.push "#{message}"
  end

  request = EventMachine::HttpRequest.new('http://localhost:4567/webhook')
  sub = @channel.subscribe { |msg|
    http = request.post(:body => msg, :head => {"Content-Type" => "application/json"})
  }
end
