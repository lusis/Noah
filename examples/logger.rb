#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'rubygems'
require 'eventmachine'
require 'em-hiredis'
require 'logger'

log = Logger.new(STDOUT)

EventMachine.run do

  # Passing messages...like a boss
  @channel = EventMachine::Channel.new

  r = EventMachine::Hiredis::Client.connect
  r.psubscribe("noah.*")
  r.on(:pmessage) do |pattern, event, message|
    @channel.push "#{message}"
  end

  sub = @channel.subscribe { |msg|
    log.debug("#{msg}")
  }
end
