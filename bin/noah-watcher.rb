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

  @@watchers = Noah::Watcher.watch_list

  def initialize
    @logger = LOGGER
    @logger.debug("Initializing with #{@@watchers.size} registered watches")
    if EventMachine.reactor_running?
      @worker = EM.spawn {|event, message, watch_list|
        logger = LOGGER
        logger.debug("Worker initiated")
        logger.info("got event on http worker: #{event}")
        logger.info("got message on http worker: #{message}")
        matches = watch_list.find_all{|w| event =~ /^#{Base64.decode64(w)}/}
        logger.debug("Found #{matches.size} matches for #{event}")
        EM::Iterator.new(matches).each do |watch, iter|
          p, ep = Base64.decode64(watch).split("|")
          logger.info("Sending message to: #{ep} for pattern: #{p}")
          iter.next
        end
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
    @@watchers = Noah::Watcher.watch_list
    @logger.debug("New watch count: #{@@watchers.size}")
    #@logger.debug(@@watchers)
  end

  def broker(msg)
    # This is just for testing for now
    @logger.warn(msg)
    e,m = msg.split("|")
    be = Base64.encode64(e).gsub("\n","")
    @logger.info("Encoded event: #{be}")
    @worker.notify e, m, @@watchers.clone
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
    master_channel.push "#{event}|#{message}"
    logger.debug("Publishing [#{event}]")
  end

  sub = master_channel.subscribe {|msg|
    # We short circuit if we have no watchers
    noah.broker(msg) unless noah.watchers == 0
  }
end
