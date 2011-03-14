#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..','lib','noah','custom_watcher')

class StdoutWatcher < Noah::CustomWatcher
  redis_host "redis://127.0.0.1:6379/0"
  pattern "//noah/configuration/redis"
  destination Proc.new {|x| puts x}
  run!
end
