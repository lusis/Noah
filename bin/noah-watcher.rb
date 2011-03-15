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
  require 'noah/agents/http_agent'
  require 'noah/agents/dummy_agent'
  require 'json'
rescue LoadError
  puts HELP
  exit
end

LOGGER = Logger.new(STDOUT)

class EventMachine::NoahAgent
  include EM::Deferrable

  Noah::Agents::HttpAgent.register
  Noah::Agents::DummyAgent.register
  @@watchers = Noah::Watcher.watch_list
  @@agents = Noah::Watchers.agents

  def initialize
    @logger = LOGGER
    @logger.debug("Initializing with #{@@watchers.size} registered watches")
    @logger.debug("#{@@agents} agents registered")
    if EventMachine.reactor_running?
      self.succeed("Succeed callback")
    else
      logger.fatal("Must be inside a reactor!")
    end
  end

  def watchers
    @@watchers.size
  end

  def http_worker
    @http_worker
  end

  def reread_watchers
    @logger.debug("Found new watches")
    @logger.debug("Current watch count: #{@@watchers.size}")
    @@watchers = Noah::Watcher.watch_list
    @logger.debug("New watch count: #{@@watchers.size}")
  end

  def broker(msg)
    e,m = msg.split("|")
    be = Base64.encode64(e).gsub("\n","")
    EM::Iterator.new(@@agents).each do |agent, iter|
      agent.send(:notify, e, m, @@watchers.clone)
      iter.next
    end
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
  end

  sub = master_channel.subscribe {|msg|
    # We short circuit if we have no watchers
    noah.broker(msg) unless noah.watchers == 0
  }
end
