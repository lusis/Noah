class Noah::App
  content_type_mapping = {
            :yaml => "text/x-yaml",
            :json => "application/json",
            :xml => "text/xml",
            :string => "text/plain"
  }
  # GET the raw data of a configuration object
  get '/configurations/:configname/data/?' do |configname|
    c = Noah::Configuration.find(:name => configname).first
    (halt 404) if c.empty?
    content_type content_type_mapping[c.format.to_sym] if content_type_mapping[c.format.to_sym]
    c.body
  end
  # GET the JSON representation of a configuration object
  get '/configurations/:configname/?' do |configname|
    c = Noah::Configuration.find(:name => configname).first
    (halt 404) if c.empty?
    c.to_json
  end
  # GET all configurations
  get '/configurations/?' do
    configs = Noah::Configurations.all.to_hash
    (halt 404) if configs.size == 0
    configs.to_json
  end
  # Add configuration object to a custom link hierarchy
  put '/configurations/:configname/link' do |configname|
    required_params = ["link_name"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (a = Noah::Configuration.find(:name => configname).first) : (raise "Missing Parameters")
    a.nil? ? (halt 404) : (a.link! data["link_name"])
    a.to_json
  end
  # Add a tag to a configuration object
  put '/configurations/:configname/tag' do |configname|
    required_params = ["tags"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (c=Noah::Configuration.find(:name=>configname).first) : (raise "Missing Parameters")
    c.nil? ? (halt 404) : (c.tag!(data['tags']))
    c.to_json

  end
  # Add a watch to a configuration object
  put '/configurations/:configname/watch' do |configname|
    required_params = ["endpoint"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (c = Noah::Configuration.find(:name => configname).first) : (raise "Missing Parameters")
    c.nil? ? (halt 404) : (w = c.watch!(:endpoint => data['endpoint']))
    w.to_json
  end
  # Attach a configuration object to an application object
  put '/configurations/:configname/:appname?' do |configname, appname|
    app = Noah::Application.find_or_create(:name => appname)
    dependency_action = app.is_new? ? "created" : "updated"
    config = Noah::Configuration.find_or_create(:name => configname)
    required_params = ["format", "body"]
    data = JSON.parse(request.body.read)
    data.keys.sort == required_params.sort  ? (config.format = data["format"]; config.body = data["body"]) : (raise "Missing Parameters")
    if config.valid?
      config.save
      app.configurations << config
      app.save
      action = config.is_new? ? "create" : "update"
      r = {"result" => "success","id" => "#{config.id}", "action" => action, "dependencies" => dependency_action, "application" => app.name, "item" => config.name}
      r.to_json
    else
      raise "#{format_errors(config)}"
    end
  end

  delete '/configurations/:configname/:appname?' do |configname, appname|
    app = Noah::Application.find(:name => appname).first
    cfg = app.configurations.find(:name => configname).first
# Check with soveran. If we delete the member from the set using .delete, it removes the object. That would break any other users of that object.
    (halt 404) if app.empty?
    (halt 404) if config.empty?
    if app
      config = app.configurations.find(:name=> element).first
      if config
        app.configurations.delete(config)
        r = {"result" => "success", "id" => "#{config.id}", "action" => "delete", "application" => "#{app.name}", "item" => "#{element}"}
        r.to_json
      else
        halt 404
      end
    else
      halt 404
    end
  end
end
