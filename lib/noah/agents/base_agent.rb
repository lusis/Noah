require 'logger'
require 'logger'

module Noah::Agents
  module Base
    class << self
      include EM::Deferrable

      PREFIX = "base"
      NAME = "base-agent"
    end

    def self.included(base)
      Noah::Watchers.register_agent(base)
    end
  end
end
