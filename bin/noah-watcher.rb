#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'rubygems'
require 'logger'
require 'optparse'
require 'em-hiredis'
require 'thin'
require 'noah'
require 'json'

LOGGER = Logger.new(STDOUT)

class EventMachine::NoahAgent
  include EM::Deferrable

  @@watchers = Noah::Watchers.all

  def initialize
    @logger = LOGGER
    @logger.debug("Initializing with #{@@watchers.size} registered watches")
    # Some logic to spawn protocol specific agents
    # i.e. http, amqp, xmpp, redis, whatever
    if EventMachine.reactor_running?
      @http_worker = EM.spawn {|msg, ep|
        logger = LOGGER
        logger.debug("spawning http processor")
        logger.info("got ep on http worker: #{ep}")
        logger.info("got msg on http worker: #{msg}")
      }
      @redis_worker = EM.spawn {|msg|
        logger = LOGGER
        logger.debug("spawning redis worker")
        logger.info("got msg on redis worker: #{msg}")
      }
      @log_worker = EM.spawn {|msg|
        logger = LOGGER
        logger.debug("spawning logger worker: #{msg}")
      }
      @amqp_worker = EM.spawn {|msg|
        logger = LOGGER
        logger.debug("spawning amqp worker: #{msg}")
      }
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
    @@watchers = Noah::Watchers.all
    @logger.debug("New watch count: #{@@watchers.size}")
    @logger.debug(@@watchers)
  end

  def broker(msg)
    # This is just for testing for now
    @logger.info(msg.class)
    @logger.warn(msg)
    e,m = msg.split("\t")

    @http_worker.notify m, e
  end
end

EventMachine.run do
  logger = LOGGER
  noah = EventMachine::NoahAgent.new
  # Passing messages...like a boss
  master_channel = EventMachine::Channel.new

  r = EventMachine::Hiredis::Client.connect
  logger.debug("Starting up")
  r.psubscribe("//noah/*")
  r.on(:pmessage) do |pattern, event, message|
    noah.reread_watchers if event =~ /^\/\/noah\/watcher\/.*/
    master_channel.push "#{event}\t#{message}"
    logger.debug("Publishing [#{event}]")
  end

  sub = master_channel.subscribe {|msg|
    noah.broker(msg) unless noah.watchers == 0
  }
end
