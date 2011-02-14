#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'rubygems'
require 'em-websocket'
require 'em-hiredis'
require 'thin'
require 'noah'
## Uncomment the following to hardcode a redis url
#ENV['REDIS_URL'] = "redis://localhost:6379/0"

EventMachine.run do

  # Passing messages...like a boss
  @channel = EventMachine::Channel.new

  Thin::Server.start Noah::App
  r = EventMachine::Hiredis::Client.connect
  r.psubscribe("noah.*")
  r.on(:pmessage) do |pattern, event, message|
    @channel.push "(#{event}) #{message}"
  end

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 3001) do |ws|
    ws.onopen {
      sub = @channel.subscribe { |msg| 
        ws.send msg 
      }

      @channel.push "#{sub} connected and waiting...."

      ws.onmessage { |msg|
        @channel.push "<#{sub}>: #{msg}"
      }

      ws.onclose {
        @channel.unsubscribe(sub)
      }
    }
  end

end
