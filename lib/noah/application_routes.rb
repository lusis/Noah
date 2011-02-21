class Noah::App
  # Application URIs
  get '/a/:appname/:config/?' do |appname, config|
    app = Noah::Application.find(:name => appname).first
    if app.nil?
      halt 404
    else  
      c = Noah::Configuration.find(:name => config, :application_id => app.id).first
      c.to_json
    end  
  end

  get '/a/:appname/?' do |appname|
    app = Noah::Application.find(:name => appname).first
    if app.nil?
      halt 404
    else
      app.to_json
    end
  end

  put '/a/:appname/?' do |appname|
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
      raise "#{app.errors}"
    end
  end

  delete '/a/:appname/?' do |appname|
    app = Noah::Application.find(:name => appname).first
    if app.nil?
      halt 404
    else
      configurations = []
      Noah::Configuration.find(:application_id => app.id).sort.each {|x| configurations << x; x.delete} if app.configurations.size > 0
      app.delete
      r = {"result" => "success", "action" => "delete", "id" => "#{app.id}", "name" => "#{appname}", "configurations" => "#{configurations.size}"}
      r.to_json
    end
  end

  get '/a/?' do
    apps = []
    Noah::Application.all.sort.each {|a| apps << a.to_hash}
    if apps.empty?
      halt 404
    else  
      apps.to_json
    end  
  end
end
