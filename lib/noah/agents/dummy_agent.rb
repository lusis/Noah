require File.join(File.dirname(__FILE__), 'base_agent')

module Noah::Agents
  class DummyAgent
    include Noah::Agents::Base

    PREFIX = "dummy://"
    NAME = self.name

    def self.callback!(matches, message)
      EM::Iterator.new(matches).each do |watch, iter|
        p, ep = watch.split("|")
        logger.info("Sending message to: #{ep} for pattern: #{p}")
        logger.debug("message received: #{message}")
        iter.next
      end
    end

  end
end
