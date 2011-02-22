require 'eventmachine'
require 'uri'

require File.join(File.dirname(__FILE__), 'passthrough')
require File.join(File.dirname(__FILE__), '..','vendor','em-hiredis','lib','em-hiredis')

module Noah

  class Watcher
    extend Passthrough

    passthrough :redis_host, :pattern, :destination, :run!, :run_watcher

    attr_accessor :my_pattern, :my_destination, :my_redis

    def self.watch(&blk)
      watcher = Noah::Watcher.new
      watcher.instance_eval(&blk) if block_given?
      watcher
    end

    def initialize
      @my_redis ||= ENV['REDIS_URL']
      @my_pattern ||= 'noah.*'
    end

    def self.redis_host(host)
      @my_redis = host
    end

    def self.pattern(pattern)
      @my_pattern = pattern
    end

    def self.destination(destination)
      @my_destination = destination
    end

    def self.run!
      @my_destination.nil? ? (raise ArgumentError) : run_watcher(@my_destination)
    end

    private
    def self.run_watcher(dest)
      redis_url = URI.parse(@my_redis)
      db = redis_url.path.gsub(/\//,'')
      EventMachine.run do
        channel = EventMachine::Channel.new
        r = EventMachine::Hiredis::Client.connect(redis_url.host, redis_url.port)
        r.psubscribe("#{db}:#{@my_pattern}")
        r.on(:pmessage) do |pattern, event, message|
          channel.push "#{message}"
        end

        sub = channel.subscribe {|msg| dest.call(msg)}
      end
    end
  end

end
