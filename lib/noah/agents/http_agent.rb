require File.join(File.dirname(__FILE__), 'base_agent')

module Noah::Agents
  class HttpAgent
    include Noah::Agents::Base

    PREFIX = "http://"
    NAME = self.name

    def self.callback!(matches, message)
      EM::Iterator.new(matches, 100).each do |watch, iter|
        p, ep = watch.split("|")
        logger.info("Sending message to (#{ep}) for pattern (#{p})")
        http = EM::HttpRequest.new(ep, :connection_timeout => 2, :inactivity_timeout => 4).post :body => message
        http.callback {
          logger.info("Message posted to #{ep} successfully")
        }
        http.errback {
          logger.error("Something went wrong with #{ep}")
        }
        iter.next
      end
    end

  end
end
