require 'rubygems'
require 'eventmachine'
require 'em-hiredis'

module Noah
  class Watcher
    attr_accessor :pattern, :destination
  
    def initialize(&blk)
      @pattern ||= "noah.*"
      @destination ||= nil
      yield(self) if block_given?
    end

    def run!
      @destination.nil? ? (puts "Can't run without a destination") : run_watcher(@destination)
    end

    private
    def run_watcher(dest)
      EventMachine.run do
        channel = EventMachine::Channel.new

        r = EventMachine::Hiredis::Client.connect
        r.psubscribe(@pattern)
        r.on(:pmessage) do |pattern, event, message|
          channel.push "#{message}"
        end

        sub = channel.subscribe {|msg| dest.call(msg)}
      end
    end

  end
end
