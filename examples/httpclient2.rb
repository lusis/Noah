#!/usr/bin/env ruby

require 'pp'
require File.join(File.dirname(__FILE__), '..','lib','noah.rb')

# This doesn't actually send watch notifications
# but it shows how you could register a new watch
# for the agents to handle
a = Noah::Application.new
a.name = "my_kickass_application"
a.valid?
a.save

a.watch! :endpoint => 'http://localhost:4567/webhook' # Boom headshot
pp Noah::Watcher.find(:pattern => "noah.application.my_kickass_application.*").first
# Default watch pattern is 'noah.model.name.*'

# You can also register a new watch with a custom pattern
b = Noah::Application.new
b.name = "my_other_awesome_app"
b.valid?
b.save
b.watch! :endpoint => 'http://localhost:4567/webhook', :pattern => 'delete'
pp Noah::Watcher.find(:pattern => "noah.application.my_other_awesome_app.delete").first
# There's now a watcher for pattern 'noah.application.my_other_awesome_app.delete'

# The idea now is that some background watcher agent will pick up on these registered watches
# See https://github.com/lusis/Noah/wiki/Watcher-Braindump
