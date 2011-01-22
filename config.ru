require 'rubygems'
require 'sinatra'
require 'sinatra/namespace'

require File.join(File.dirname(__FILE__), 'app')

set :env, :development
set :root, File.dirname(__FILE__)
set :server, %[thin mongrel webrick]
set :logging, true
set :raise_errors, false
set :show_exceptions, false
disable :run

run Sinatra::Application
