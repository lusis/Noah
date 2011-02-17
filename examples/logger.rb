#!/usr/bin/env ruby
require './watcher-idea.rb'
require 'logger'

log = Logger.new(STDOUT)

Noah::Watcher.watch do
  pattern "noah.Application*"
  destination Proc.new {|x| log.debug(x)}
  run!
end
