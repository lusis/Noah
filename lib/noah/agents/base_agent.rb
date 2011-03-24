module Noah::Agents
  module Base
    class <<self
      PREFIX = "base"
      NAME = "base-agent"
    end

    def self.included(base)
      Noah::Watchers.register_agent(base)
      base.send :include, EM::Deferrable
      base.send :extend, AgentClassMethods
    end
  end

  module AgentClassMethods

    def logger
      Noah::Log.logger.progname = self.name
      Noah::Log.logger
    end

    def find_watched_patterns!(watchlist)
      watched_patterns = []
      watchlist.find_all do |w|
        p, ep = Base64.decode64(w).split('|')
        watched_patterns << "#{p}|#{ep}" if ep =~ /^#{self.const_get("PREFIX")}/
      end
      watched_patterns
    end

    def notify(event, message, watch_list)
      logger.info("Worker Initiated")
      logger.debug("got event - #{event}")
      watched_patterns = find_watched_patterns!(watch_list)
      matches = watched_patterns.find_all {|w| event =~ /^#{w}/}
      logger.debug("Found #{matches.size} matches for #{event}")
      self.callback!(matches, message)
    end

  end
end
