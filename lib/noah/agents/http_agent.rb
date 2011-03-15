require 'logger'

module Noah::Agents
  class HttpAgent
    include EM::Deferrable

    PREFIX = "http"
    NAME = "http"

    def self.register
      Noah::Watchers.register_agent(self)
    end

    def self.notify(event, message, watch_list)
      logger = LOGGER
      logger.info("#{NAME}: Worker initiated")
      logger.debug("#{NAME}: got event - #{event}")
      matches = watch_list.find_all{|w| event =~ /^#{Base64.decode64(w)}/}
      logger.debug("#{PREFIX}: Found #{matches.size} possible matches for #{event}")
      EM::Iterator.new(matches).each do |watch, iter|
        p, ep = Base64.decode64(watch).split("|")
        if ep =~ /^#{PREFIX}/
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
end
