class Noah::App
  # Stubbing Ephemeral endpoints
  get '/e/?' do
    halt 404
  end

  get '/e/*' do
    params["splat"].size == 0 ? (halt 404) : (e=Noah::Ephemeral.find(:path => "/#{params["splat"][0]}").first)
    (halt 404) if e.nil?
    content_type "application/octet-stream"
    e.data.nil? ? "" : "#{e.data}"
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
    d = request.body.read  || nil
    e = Noah::Ephemeral.find_or_create(:path => "/#{params[:splat][0]}")
    e.data = d
    if e.valid?
      e.save
      action = e.is_new? ? "create" : "update"
      r = {"action" => action, "result" => "success", "id" => e.id, "path" => e.path, "data" => e.data}
      r.to_json
    else
      raise "#{format_errors(e)}"
    end
  end

  delete '/e/*' do
    p = params[:splat][0]
    e = Noah::Ephemeral.find(:path => "/"+p).first
    if e
      e.delete
      r = {"result" => "success", "id" => "#{e.id}", "action" => "delete", "path" => e.name}
      r.to_json
    else
      halt 404
    end
  end

end
