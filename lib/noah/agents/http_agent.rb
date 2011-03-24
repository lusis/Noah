require File.join(File.dirname(__FILE__), 'base_agent')

module Noah::Agents
  class HttpAgent
    include Noah::Agents::Base

    PREFIX = "http://"
    NAME = "http"

    def self.notify(event, message, watch_list)
      logger = LOGGER
      logger.info("#{NAME}: Worker initiated")
      logger.debug("#{NAME}: got event -  #{event}")
      watched_patterns = find_watched_patterns!(watch_list)
      matches = watched_patterns.find_all {|w| event =~ /^#{w}/}
      logger.debug("#{NAME}: Found #{matches.size} matches for #{event}")
      EM::Iterator.new(matches, 100).each do |watch, iter|
        p, ep = watch.split("|")
        logger.info("#{NAME}: Sending message to (#{ep}) for pattern (#{p})")
        http = EM::HttpRequest.new(ep, :connection_timeout => 2, :inactivity_timeout => 4).post :body => message
        http.callback {
          logger.info("#{NAME}: Message posted to #{ep} successfully")
        }
        http.errback {
          logger.error("#{NAME}: Something went wrong with #{ep}")
        }
        iter.next
      end
    end

  end
end
