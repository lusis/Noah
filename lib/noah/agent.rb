$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))
require 'rubygems'
require 'noah'
require 'noah/agents/http_agent'
require 'noah/agents/dummy_agent'
begin
  candidates = []
  Gem.source_index.find_all {|g| candidates << g[1].name if g[1].name =~ /^noah-agents-.*/}
  candidates.each do |c|
    require c
  end
rescue LoadError
  puts "Unable to load #{c}"
end


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
        #instantiate_agents!
        @logger.info("Started up!")
      else
        @logger.fatal("Must be inside a reactor!")
      end
    end

    def watchers
      @@watchers.size
    end

    def reread_watchers
      @logger.info("Found new watches")
      @logger.debug("Current watch count: #{@@watchers.size}")
      @@watchers = Noah::Watcher.watch_list
      @logger.debug("New watch count: #{@@watchers.size}")
    end

    def broker(msg)
      e,m = msg.split("|")
      EM::Iterator.new(@@agents, @@agents.size).each do |agent, iter|
        #a = agent.to_s.gsub(/::/,'_').downcase
        x = agent.send(:new)
        begin
          #self.instance_variable_get("@#{a}").send(:notify, e, m, @@watchers)
          x.notify(e, m, @@watchers.clone)
          iter.next
        rescue Exception => e
          @logger.error("#{agent.to_s} invocation failed with #{e.message}")
        end
      end
    end

    protected
    def instantiate_agents!
      @@agents.each do |agent|
        # Convert Noah::Agents::HttpAgent to
        # noah_agents_httpagent
        a = agent.to_s.gsub(/::/,'_').downcase
        @logger.debug("#{a}")
        # Create instance variable of a
        self.class.send :attr_accessor, a.to_sym
        # Set the instance variable "a" to instance of agent
        self.instance_variable_set(:"@#{a}", agent.send(:new))
      end
    end
    def find_and_register_agents
      candidates = []
      Gem.source_index.find_all {|g| candidates << g[1].name if g[1].name =~ /^noah-agent-.*/}
      candidates.each do |c|
        begin
          require c
        rescue LoadError
          Noah::Log.logger.warn("Unable to load #{c}")
        end
      end
    end

  end
end
