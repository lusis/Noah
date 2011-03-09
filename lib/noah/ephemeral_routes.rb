require 'logger'
require 'base64'
class Noah::App
  # Stubbing Ephemeral endpoints
  get '/e/?' do
    halt 404
  end

  get '/e/*' do
    logger = Logger.new(STDOUT)
    params["splat"].size == 0 ? (halt 404) : (e=Noah::Ephemeral.find(:path => "/#{params["splat"][0]}").first)
    return e.to_json
  end

  put '/e/*/watch' do
    required_params = ["endpoint"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (e = Noah::Watcher.find(:path => params[:splat][0]).first) : (raise "Missing Parameters")
    e.nil? ? (halt 404) : (w = e.watch!(:endpoint => data["endpoint"]))
    w.to_json
  end

  put '/e/*' do
    raise("Data too large") if request.body.size > 512
    d = Base64.encode64(request.body.read)  || nil
    e = Noah::Ephemeral.new(:path => params[:splat][0], :data => d)
    e.valid? ? (e.save; e.to_json) : (raise "#{e.errors}")
  end

  delete '/e/*' do
    p = params[:splat][0]
    e = Noah::Ephemeral.find(:path => p).first
    if e
      e.delete
      r = {"result" => "success", "id" => "#{e.id}", "action" => "delete", "path" => e.name}
      r.to_json
    else
      halt 404
    end
  end

end
