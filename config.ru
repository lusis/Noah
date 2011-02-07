require File.join(File.dirname(__FILE__), 'lib','noah')
ENV['REDIS_URL'] = "redis://localhost:6379/0"
run Noah::App
