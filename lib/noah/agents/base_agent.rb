require 'logger'

module Noah::Agents
  module Base
    class << self
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

    def find_watched_patterns!(watchlist)
      watched_patterns = []
      watchlist.find_all do |w|
        p, ep = Base64.decode64(w).split('|')
        watched_patterns << "#{p}|#{ep}" if ep =~ /^#{self.const_get("PREFIX")}/
      end
      watched_patterns
    end

  end
end
