class Noah::App

  get '/watches/:name' do |name|
    w = Noah::Watcher.find_by_name(name)
    w.nil? ? (halt 404) : w.to_json
  end

  get '/watches/?' do
    w = Noah::Watcher.all.sort_by(:pattern)
    if w.size == 0
      halt 404
    else  
      w.to_json
    end 
  end

  put '/watches/?' do
    required_params = %w[endpoint pattern]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (pattern, endpoint = data['pattern'],data['endpoint']) : (raise "Missing Parameters")
    w = Noah::Watcher.create(:pattern => pattern, :endpoint => endpoint)
    if w.valid?
        w.save
        r = {"action" => "create", "result" => "success"}.merge(w.to_hash)
        r.to_json
    else
        raise "#{format_errors(w)}"
    end
  end

  delete '/watches/?' do
    required_params = %w[endpoint pattern]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (pattern, endpoint = data['pattern'],data['endpoint']) : (raise "Missing Parameters")
    w = Noah::Watcher.find(:pattern => pattern, :endpoint => endpoint).first
    if w.nil?
      halt 404
    else
      w.delete
      r = {"result" => "success", "action" => "delete"}.merge(w.to_hash)
      r.to_json
    end
  end

end
