#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
  HELP = <<-EOH
  Unfortunately, the agent script has some difficult requirements right now.
  Please see https://github.com/lusis/Noah/Watcher-Agent for details.
  EOH
begin
  require 'rubygems'
  require 'logger'
  require 'optparse'
  require 'em-hiredis'
  require 'eventmachine'
  require 'em-http-request'
  require 'noah'
  require 'json'
rescue LoadError
  puts HELP
  exit
end

LOGGER = Logger.new(STDOUT)

class EventMachine::NoahAgent
  include EM::Deferrable

  @@watchers = Noah::Watcher.watch_list

  def initialize
    @logger = LOGGER
    @logger.debug("Initializing with #{@@watchers.size} registered watches")
    if EventMachine.reactor_running?
      @worker = EM.spawn {|event, message, watch_list|
        logger = LOGGER
        logger.info("Worker initiated")
        logger.debug("got event on http worker: #{event}")
        matches = watch_list.find_all{|w| event =~ /^#{Base64.decode64(w)}/}
        logger.debug("Found #{matches.size} matches for #{event}")
        EM::Iterator.new(matches).each do |watch, iter|
          p, ep = Base64.decode64(watch).split("|")
          logger.info("Sending message to: #{ep} for pattern: #{p}")
          http = EM::HttpRequest.new(ep, :connection_timeout => 2, :inactivity_timeout => 4).post :body => message
          http.callback {
            logger.info("Message posted to #{ep} successfully")
          }
          http.errback {
            logger.error("Something went wrong")
          }
          iter.next
        end
      }
      self.succeed("Succeed callback")
    else
      logger.fatal("Must be inside a reactor!")
    end
  end

  def watchers
    @@watchers.size
  end

  def reread_watchers
    @logger.debug("Found new watches")
    @logger.debug("Current watch count: #{@@watchers.size}")
    @@watchers = Noah::Watcher.watch_list
    @logger.debug("New watch count: #{@@watchers.size}")
    #@logger.debug(@@watchers)
  end

  def broker(msg)
    # This is just for testing for now
    e,m = msg.split("|")
    be = Base64.encode64(e).gsub("\n","")
    @worker.notify e, m, @@watchers.clone
  end
end

EventMachine.run do
  EM.error_handler do |e|
    Logger.new(STDOUT).warn(e)
  end
  logger = LOGGER
  trap("INT") { logger.debug("Shutting down. Watches will not be fired");EM.stop }
  noah = EventMachine::NoahAgent.new
  noah.errback{|x| logger.error("Errback: #{x}")}
  noah.callback{|y| logger.info("Callback: #{y}")}
  # Passing messages...like a boss
  master_channel = EventMachine::Channel.new

  r = EventMachine::Hiredis::Client.connect
  r.errback{|x| logger.error("Unable to connect to redis: #{x}")}
  logger.debug("Starting up")
  r.psubscribe("//noah/*")
  r.on(:pmessage) do |pattern, event, message|
    noah.reread_watchers if event =~ /^\/\/noah\/watcher\/.*/
    master_channel.push "#{event}|#{message}"
    logger.debug("Saw[#{event}]")
  end

  sub = master_channel.subscribe {|msg|
    # We short circuit if we have no watchers
    noah.broker(msg) unless noah.watchers == 0
  }
end
