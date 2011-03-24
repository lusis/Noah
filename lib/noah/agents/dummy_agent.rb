require File.join(File.dirname(__FILE__), 'base_agent')

module Noah::Agents
  class DummyAgent
    include Noah::Agents::Base

    PREFIX = "dummy://"
    NAME = "dummy"

    def self.notify(event, message, watch_list)
      logger = LOGGER
      logger.info("#{NAME}: Worker initiated")
      logger.debug("#{NAME}: got event -  #{event}")
      watched_patterns = find_watched_patterns!(watch_list)
      matches = watched_patterns.find_all {|w| event =~ /^#{w}/}
      logger.debug("#{NAME}: Found #{matches.size} matches for #{event}")
      EM::Iterator.new(matches).each do |watch, iter|
        p, ep = watch.split("|")
        logger.info("#{NAME}: Sending message to: #{ep} for pattern: #{p}")
        logger.debug("#{NAME}: message received: #{message}")
        iter.next
      end
    end

  end
end
