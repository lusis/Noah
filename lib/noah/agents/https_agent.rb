require File.join(File.dirname(__FILE__), 'http_agent')
module Noah::Agents
  class HttpsAgent < HttpAgent
    PREFIX = "https://"
  end
end
