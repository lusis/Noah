#!/usr/bin/env ruby
require './watcher-idea.rb'

f = Noah::Watcher.new do |f|
  f.pattern = "noah.Configuration*"
  f.destination = Proc.new {|x| puts x}
end
f.run!
