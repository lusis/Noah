#!/usr/bin/env ruby
require './watcher-idea.rb'
require 'logger'

log = Logger.new(STDOUT)

Noah::Watcher.watch do
  pattern "noah.Noah::Application*"
  destination Proc.new {|x| log.debug(x)}
  run!
end
