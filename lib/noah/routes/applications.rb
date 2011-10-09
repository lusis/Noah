class Noah::App
  # Application URIs
  get '/applications/:appname/configurations/:config/?' do |appname, config|
    app = Noah::Application.find(:name => appname).first
    (halt 404) if app.nil?
    request.path_info = "/configurations/#{config}"
    pass
  end

  get '/applications/:appname/?' do |appname|
    app = Noah::Application.find(:name => appname).first
    (halt 404) if app.nil?
    app.to_json
  end

  put '/applications/:appname/watch' do |appname|
    required_params = ["endpoint"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (a = Noah::Application.find(:name => appname).first) : (raise "Missing Parameters")
    a.nil? ? (halt 404) : (w = a.watch!(:endpoint => data['endpoint']))
    w.to_json
  end

  put '/applications/:appname/link' do |appname|
    required_params = ["link_name"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (a = Noah::Application.find(:name => appname).first) : (raise "Missing Parameters")
    a.nil? ? (halt 404) : (a.link! data["link_name"])
    a.to_json
  end

  put '/applications/:appname/configurations/:configname/?' do |appname, configname|
    required_params = ["format", "body"]
    raise "Missing Parameters" if request.body.nil?
    data = JSON.parse(request.body.read)
    raise "Missing Parameters" if data.keys.sort != required_params.sort
    add_config_to_app(appname, {:name => configname, :format => data['format'], :body => data['body']})
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
      #app.save
      r = {"result" => "success","id" => app.id, "action" => action, "name" => app.name }
      r.to_json
    else
      raise "#{format_errors(app)}"
    end
  end

  delete '/applications/:appname/?' do |appname|
    app = Noah::Application.find(:name => appname).first
    (halt 404) if app.nil?
    app.delete
    r = {"result" => "success", "action" => "delete", "id" => "#{app.id}", "name" => "#{appname}"}
    r.to_json
  end

  delete '/applications/:appname/configurations/:configname/?' do |appname, configname|
    app = Noah::Application.find(:name => appname).first
    (halt 404) if app.nil?
    config = Noah::Configuration.find(:name => configname).first
    (halt 404) if config.nil?
    if app.configurations.member?(config)
      app.configurations.delete(config)
      r = {"result" => "success", "action" => "delete", "id" => "#{app.id}", "name" => "#{app.name}", "configuration" => "#{config.name}"}
      r.to_json
    else
      halt 404
    end
  end

  get '/applications/?' do
    apps = Noah::Applications.all
    (halt 404) if apps.size == 0
    apps.to_json
  end
end
