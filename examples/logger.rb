#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..','lib','noah','custom_watcher')
require 'logger'

class LoggingWatcher < Noah::CustomWatcher
  redis_host "redis://127.0.0.1:6379/0"
  pattern "//noah"
  destination Proc.new {|x| log = Logger.new(STDOUT); log.debug(x)}
  run!
end
