class Noah::App
  get '/ephemerals/?' do
    halt 404
  end

  get '/ephemerals/*' do
    params["splat"].size == 0 ? (halt 404) : (e=Noah::Ephemeral.find(:path => "/#{params["splat"][0]}").first)
    (halt 404) if e.nil?
    content_type "application/octet-stream"
    e.data.nil? ? "" : "#{e.data}"
  end

  put '/ephemerals/*/watch' do
    required_params = ["endpoint"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (e = Noah::Watcher.find(:path => params[:splat][0]).first) : (raise "Missing Parameters")
    e.nil? ? (halt 404) : (w = e.watch!(:endpoint => data["endpoint"]))
    w.to_json
  end

  put '/ephemerals/*' do
    raise("Data too large") if request.body.size > 512
    d = request.body.read  || nil
    opts = {:path => "/#{params[:splat][0]}", :data => d}
    e = Noah::Ephemeral.find_or_create(opts)
    if e.valid?
      action = e.is_new? ? "create" : "update"
      r = {"action" => action, "result" => "success", "id" => e.id, "path" => e.path, "data" => e.data, "created_at" => e.created_at, "updated_at" => e.updated_at}
      r.to_json
    else
      raise "#{format_errors(e)}"
    end
  end

  delete '/ephemerals/*' do
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
