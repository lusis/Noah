#!/usr/bin/env ruby
require './watcher-idea.rb'

Noah::Watcher.watch do
  pattern "noah.Configuration*"
  destination Proc.new {|x| puts x}
  run!
end
