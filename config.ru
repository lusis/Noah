require 'rubygems'
require 'sinatra'

require File.join(File.dirname(__FILE__), 'app')

set :env, :development
set :root, File.dirname(__FILE__)
set :server, %[thin mongrel webrick]
disable :run

set :raise_errors, true
run Sinatra::Application
