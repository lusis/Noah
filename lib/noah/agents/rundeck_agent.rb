require File.join(File.dirname(__FILE__), 'base_agent')
require 'em-http/middleware/cookie_jar'
require 'uri'

module Noah::Agents
  class RunDeckAgent < Base

    PREFIX = "rundeck://"
    NAME = self.class.to_s
    DEFAULT_CONCURRENCY = 50

    def work!(ep, message)
        logger.info("Sending message to (#{ep})")
        uri = URI.parse(ep)
        credentials = {:j_username => uri.user, :j_password => uri.password}
        EM::HttpRequest.use EM::Middleware::CookieJar
        conn = EM::HttpRequest.new("http://#{uri.host}:#{uri.port}/j_security_check")
        http = conn.post :body => credentials
        http.callback {
          logger.info("Logged in to RunDeck. Calling path")
          conn2 = EM::HttpRequest.new("http://#{uri.host}:#{uri.port}#{uri.path}?#{uri.query}")
          exec = conn2.get
          exec.callback {
            logger.info("Successfully called #{ep}")
            logger.info("Response from RunDeck:")
            logger.info("#{exec.response}")
          }
          exec.errback {
            logger.error("Something went wrong with #{ep}")
          }
        }
        http.errback {
          logger.error("Something went wrong with #{ep}")
        }
    end

  end
end
