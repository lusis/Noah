require 'sinatra/base'
require 'json'

class NoahPostDemo < Sinatra::Base
  configure do
    set :app_file, __FILE__
    set :server, %w[thin]
    set :logging, true
    set :run, true
  end

  post '/webhook/?' do
    x = request.body.read
    p JSON.load(x)
  end

end
