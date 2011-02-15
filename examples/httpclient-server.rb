require 'sinatra'
post '/webhook' do
  p request.body.read
end
