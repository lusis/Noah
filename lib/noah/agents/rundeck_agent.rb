require File.join(File.dirname(__FILE__), 'base_agent')
require 'nokogiri'

module Noah::Agents
  class RunDeckAgent < Base

    PREFIX = "rundeck://"
    NAME = self.class.to_s
    DEFAULT_CONCURRENCY = 50
    SUPPORTED_PATHS = ["refresh", "run"]

    def work!(ep, message)
        logger.info("Sending message to (#{ep})")
        rd = rundeck_parser(ep)
        req = EM::HttpRequest.new(rd[:url], :connection_timeout => 2, :inactivity_timeout => 2)
        http = req.send(:"#{rd[:http_method]}", :head => {"X-RunDeck-Auth-Token" => "#{rd[:token]}"})
        http.callback {
          logger.info("Message posted to #{ep}")
          rd_resp = rundeck_response(http.response)
          http.fail("#{rd_resp[:message]}") if rd_resp[:status] == "error"
        }
        http.errback {
          logger.error("Something went wrong with #{ep}: #{http.response}")
        }
    end

    private
    def rundeck_parser(endpoint)
      rd = {}
      logger.debug("Parsing endpoint: #{endpoint}")
      begin
        rduri = URI.parse(endpoint)
      rescue URI::InvalidURIError
        logger.error("Invalid callback destination")
      end

      rduri.user.nil? ? self.fail("Missing API Token") : rd[:token]=rduri.user
      # valid paths are:
      # "/refresh/<project_name>"
      # or
      # "/run/<job_id>"
      rduri.path.split("/").size < 3 ? logger.error("Path must contain job number") : action=rduri.path.split("/")[1]
      case action
        when "run"
          realpath = "api/1/job/#{rduri.path.split("/")[2]}/run"
          rd[:http_method] = "get"
        when "refresh"
          realpath = "api/2/project/#{rduri.path.split("/")[2]}/resources/refresh"
          rd[:http_method] = "post"
        else
          logger.error("I only handle jobs and refreshes for now. Sorry!")
        end
      rd[:url] = "http://#{rduri.host}:#{rduri.port}/#{realpath}"
      logger.debug("Returning to work with params: #{rd.to_s}")
      rd
    end

    def rundeck_response(response)
      xml = Nokogiri::XML.parse(response)
      keys = xml.xpath("//result").collect(&:keys).first
      keys.member?("error") ? status="error" : status="success"
      message = xml.xpath("//result").collect(&:text)
      {:status => status, :message => message}
    end
  end
end
