require File.join(File.dirname(__FILE__), 'base_agent')

module Noah::Agents
  class HttpAgent < Base

    PREFIX = "http://"
    NAME = self.class.to_s
    DEFAULT_CONCURRENCY = 50

    def work!(ep, message)
        logger.info("Sending message to (#{ep})")
        http = EM::HttpRequest.new(ep, :connection_timeout => 2, :inactivity_timeout => 2).post :body => message
        http.callback {
          logger.info("Message posted to #{ep} successfully")
        }
        http.errback {
          logger.debug("Error posting to #{ep}: #{http.response}.")
        }
    end

  end
end
