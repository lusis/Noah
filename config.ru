require 'rubygems'
require 'sinatra'
require 'sinatra/namespace'

require File.join(File.dirname(__FILE__), 'app')

set :env, :development
set :root, File.dirname(__FILE__)
set :server, %[thin mongrel webrick]
set :logging, true if development?
set :raise_errors, true if development?
disable :run

run Sinatra::Application
