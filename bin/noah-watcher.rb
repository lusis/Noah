#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'rubygems'
require 'logger'
require 'optparse'
require 'em-hiredis'
require 'thin'
require 'noah'

EventMachine.run do
  @logger = Logger.new(STDOUT)
  # Passing messages...like a boss
  @channel = EventMachine::Channel.new

  r = EventMachine::Hiredis::Client.connect
  r.psubscribe("//noah/*")
  r.on(:pmessage) do |pattern, event, message|
    
    @channel.push "[#{event}] [#{message}]"
    @logger.debug("Publishing [#{event}]")
  end

  sub = @channel.subscribe {|msg|
    puts msg
  }
#  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 3001) do |ws|
#    ws.onopen {
#      sub = @channel.subscribe { |msg| 
#        ws.send msg 
#      }
#
#      @channel.push "#{sub} connected and waiting...."
#
#      ws.onmessage { |msg|
#        @channel.push "<#{sub}>: #{msg}"
#      }
#
#      ws.onclose {
#        @channel.unsubscribe(sub)
#      }
#    }
#  end

end
