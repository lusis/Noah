#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..','lib','noah','watcher')
require 'logger'

class LoggingWatcher < Noah::Watcher
  redis_host "redis://127.0.0.1:6379/5"
  pattern "//noah/application/*"
  destination Proc.new {|x| log = Logger.new(STDOUT); log.debug(x)}
  run!
end
