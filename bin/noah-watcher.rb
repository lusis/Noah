#!/usr/bin/env ruby
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'rubygems'
require 'logger'
require 'optparse'
require 'em-hiredis'
require 'thin'
require 'noah'

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
      @http_channel = EventMachine::Channel.new
      @redis_channel = EventMachine::Channel.new
      @log_channel = EventMachine::Channel.new
    else
      log.fatal("Must be inside a reactor!")
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
  end

  def process_message(msg)
    # This is just for testing for now
    @logger.info(msg)
  end
end

EventMachine.run do
  logger = LOGGER
  noah = EventMachine::NoahAgent.new
  # Passing messages...like a boss
  channel = EventMachine::Channel.new

  r = EventMachine::Hiredis::Client.connect
  logger.debug("Starting up")
  r.psubscribe("//noah/*")
  r.on(:pmessage) do |pattern, event, message|
    noah.reread_watchers if event =~ /^\/\/noah\/watcher\/.*/
    channel.push "[#{event}][#{message}]"
    logger.debug("Publishing [#{event}]")
  end

  sub = channel.subscribe {|msg|
    noah.process_message(msg) unless noah.watchers == 0
  }
end
