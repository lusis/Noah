require 'rubygems'
require 'logger'
require 'eventmachine'
require 'em-hiredis'


module Noah
  class Watcher
    attr_accessor :my_pattern, :my_destination
  
    def self.watch(&blk)
      watcher = Noah::Watcher.new
      watcher.instance_eval(&blk)
      watcher
    end

    def pattern(pattern)
      @my_pattern = pattern
    end

    def destination(destination)
      @my_destination = destination
    end

    def run!
      @my_destination.nil? ? (puts "Can't run without a destination") : run_watcher(@my_destination)
    end

    private
    def run_watcher(dest)
      watcher_log = Logger.new(STDOUT)
      EventMachine.run do
        watcher_log.info("Starting Noah Watcher...")
        watcher_log.info("Filtering on messages: #{@my_pattern}")
        channel = EventMachine::Channel.new

        r = EventMachine::Hiredis::Client.connect
        r.psubscribe(@my_pattern)
        r.on(:pmessage) do |pattern, event, message|
          channel.push "#{message}"
        end

        sub = channel.subscribe {|msg| dest.call(msg)}
      end
    end

  end
end
