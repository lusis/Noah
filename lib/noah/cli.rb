require 'mixlib/cli'
module Noah

  class CLI
    include Mixlib::CLI

    banner "noah (options)"

    option :config,
      :short => "-c CONFIG",
      :long => "--config CONFIG",
      :default => "config/config.yml",
      :description => "Configuration file with path"

    option :log_level,
      :short => "-l LEVEL",
      :long => "--log-level LEVEL",
      :description => "Set the log level (debug, info, warn, error, fatal)",
      :default => "info",
      :proc => Proc.new { |l| l.to_sym }

    option :port,
      :short => "-p PORT",
      :long => "--port PORT",
      :description => "Port number to listen on",
      :default => "9292"

    option :rack_opts,
      :short => "-r RACK_HANDLER",
      :long => "--rack RACK_HANDLER",
      :description => "Rack Handler to use. i.e. thin, mongrel, webbrick, Jetty (for JRuby)",
      :default => "thin"

    option :redis_url,
      :short => "-u REDIS_URL",
      :long => "--url REDIS_URL",
      :description => "Ohm-compatibile redis url. i.e. redis://localhost:6379/0",
      :default => "redis://lcoalhost:6379/0",
      :proc => Proc.new { |u| begin; require 'ohm'; Ohm.connect(:url => u); Ohm.redis.ping; rescue Errno::ECONNREFUSED => e; puts "Unable to connect to Redis. Not starting."; exit 1; end }

    option :help,
      :short => "-h",
      :long => "--help",
      :description => "You're looking at it",
      :on => :tail,
      :boolean => true,
      :show_options => true,
      :exit => 0

  end

end
