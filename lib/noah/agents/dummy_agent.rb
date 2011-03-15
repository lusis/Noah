module Noah::Agents
  class DummyAgent
    include EM::Deferrable

    PREFIX = "dummy"
    NAME = "dummy"

    def self.register
      Noah::Watchers.register_agent(self)
    end

    def self.notify(event, message, watch_list)
      logger = LOGGER
      logger.info("#{NAME}: Worker initiated")
      logger.debug("#{NAME}: got event -  #{event}")
      matches = watch_list.find_all{|w| event =~ /^#{Base64.decode64(w)}/} 
      logger.debug("#{NAME}: Found #{matches.size} possible matches for #{event}")
      EM::Iterator.new(matches).each do |watch, iter|
        p, ep = Base64.decode64(watch).split("|")
        if ep =~ /^#{PREFIX}/
          logger.info("#{NAME}: Sending message to: #{ep} for pattern: #{p}")
          logger.debug("#{NAME}: message received: #{message}")
        end
      end
      iter.next
    end

  end
end
