class Noah::App
  # Application URIs
  get '/applications/:appname/:config/?' do |appname, config|
    app = Noah::Application.find(:name => appname).first
    if app.nil?
      halt 404
    else  
      c = app.configurations.find(:name => config).first
      c.to_json
    end  
  end

  get '/applications/:appname/?' do |appname|
    app = Noah::Application.find(:name => appname).first
    if app.nil?
      halt 404
    else
      app.to_json
    end
  end

  put '/applications/:appname/tag' do |appname|
    required_params = ["tags"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (a=Noah::Application.find(:name=>appname).first) : (raise "Missing Parameters")
    a.nil? ? (halt 404) : (a.tag!(data['tags']))
    a.to_json
  end

  put '/applications/:appname/watch' do |appname|
    required_params = ["endpoint"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (a = Noah::Application.find(:name => appname).first) : (raise "Missing Parameters")
    a.nil? ? (halt 404) : (w = a.watch!(:endpoint => data['endpoint']))
    w.to_json
  end

  put '/applications/:appname/link/:linkname' do |appname, linkname|

  end

  put '/applications/:appname/?' do |appname|
    required_params = ["name"]
    data = JSON.parse(request.body.read)
    if data.keys.sort == required_params.sort && data['name'] == appname
      app = Noah::Application.find_or_create(:name => appname)
    else
      raise "Missing Parameters"
    end  
    if app.valid?
      action = app.is_new? ? "create" : "update"
      app.save
      r = {"result" => "success","id" => app.id, "action" => action, "name" => app.name }
      r.to_json
    else
      raise "#{format_errors(app)}"
    end
  end

  delete '/applications/:appname/?' do |appname|
    app = Noah::Application.find(:name => appname).first
    if app.nil?
      halt 404
    else
       # configs are no longer tied to apps. remove the cascade delete
       # configurations = []
       # Noah::Configuration.find(:application_id => app.id).sort.each {|x| configurations << x; x.delete} if app.configurations.size > 0
      app.delete
      # r = {"result" => "success", "action" => "delete", "id" => "#{app.id}", "name" => "#{appname}", "configurations" => "#{configurations.size}"}
      r = {"result" => "success", "action" => "delete", "id" => "#{app.id}", "name" => "#{appname}"}
      r.to_json
    end
  end

  get '/applications/?' do
    apps = []
    Noah::Application.all.sort.each {|a| apps << a.to_hash}
    if apps.empty?
      halt 404
    else  
      apps.to_json
    end  
  end
end
