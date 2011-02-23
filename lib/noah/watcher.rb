require 'eventmachine'
require 'uri'
require 'logger'

@log = Logger.new(STDOUT)
@log.level = Logger::DEBUG

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
      log = Logger.new(STDOUT)
      log.level = Logger::INFO
      log.debug "#{dest.inspect}"
      redis_url = URI.parse(@my_redis)
      db = redis_url.path.gsub(/\//,'')

      EventMachine.run do
        trap("TERM") { log.info "Killed"; EventMachine.stop }
        trap("INT")  { log.info "Interrupted"; EventMachine.stop }
        channel = EventMachine::Channel.new
        r = EventMachine::Hiredis::Client.connect(redis_url.host, redis_url.port)
        # Pulling out dbnum for now. Need to rethink it
        #log.info "Binding to pattern #{db}:#{@my_pattern}"
        log.info "Binding to pattern #{@my_pattern}"
        r.psubscribe("#{@my_pattern}")
        r.on(:pmessage) do |pattern, event, message|
          log.debug "Got message"
          channel.push "#{message}"
        end
        r.errback { log.info "Something went tango-uniform"; EventMachine.stop }

        sub = channel.subscribe {|msg| log.info "Calling message handler"; dest.call(msg)}
      end
    end
  end

end
