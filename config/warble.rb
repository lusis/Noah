# Disable automatic framework detection by uncommenting/setting to false
# Warbler.framework_detection = false

# Warbler web application assembly configuration file
Warbler::Config.new do |config|
  #config.features = %w(gemjar)
  config.dirs = %w(config lib views)
  config.includes = FileList["config.ru"]
  config.excludes = FileList["noah.gemspec", "Gemfile", "Gemfile.lock"]
  config.bundler = false
  config.gems += ["json", "ohm", "ohm-contrib", "sinatra", "haml"]
  config.gem_excludes = [/^(test|spec)\//]
  config.public_html = FileList["views/**/*"]
  config.webxml.booter = :rack
  #config.webxml.rackup.path = 'WEB-INF/config.ru'
  #config.webxml.rackup = %{require './lib/noah'; run Noah::App}
  # config.webxml.rackup = require 'cgi' && CGI::escapeHTML(File.read("config.ru"))
end
