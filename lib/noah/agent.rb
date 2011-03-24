$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'rubygems'
require 'logger'
require 'noah'
require 'noah/agents/http_agent'
require 'noah/agents/dummy_agent'

module Noah
  class Agent
    include EM::Deferrable

    @@watchers = Noah::Watcher.watch_list
    @@agents = Noah::Watchers.agents

    def initialize
      @logger = Noah::Log.logger
      @logger.progname = self.class.name
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
      # Below isn't being used right now
      #be = Base64.encode64(e).gsub("\n","")
      EM::Iterator.new(@@agents, @@agents.size).each do |agent, iter|
        agent.send(:notify, e, m, @@watchers.clone)
        iter.next
      end
    end
  end
end
