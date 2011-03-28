require File.join(File.dirname(__FILE__), 'base_agent')

module Noah::Agents
  class DummyAgent < Base

    PREFIX = "dummy://"
    NAME = self.class.to_s
    DEFAULT_CONCURRENCY = 10

    def work!(ep, message)
        logger.info("Sending message to: #{ep}")
        logger.info("Dummy message received: #{message}")
    end

  end
end
