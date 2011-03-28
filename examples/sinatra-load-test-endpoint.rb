require 'sinatra/base'

class NoahPostDemo < Sinatra::Base
  configure do
    set :app_file, __FILE__
    set :server, %w[thin Kirk]
    set :logging, true
    set :run, true
    set :port, 3000
  end

  post '/*' do
    x = request.body.read
  end

end
