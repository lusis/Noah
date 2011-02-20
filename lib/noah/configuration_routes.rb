class Noah::App
  content_type_mapping = {
            :yaml => "text/x-yaml",
            :json => "application/json",
            :xml => "text/xml",
            :string => "text/plain"
  }
  # Configuration URIs
  get '/c/:appname/:element/?' do |appname, element|
    a = ::Application.find(:name => appname).first
    if a.nil?
      halt 404
    else 
      c = ::Configuration.find(:name => element, :application_id => a.id).first
      content_type content_type_mapping[c.format.to_sym] if content_type_mapping[c.format.to_sym]
      c.body
    end  
  end

  get '/c/:appname/?' do |appname|
    config = []
    a = ::Application.find(:name => appname).first
    if a.nil?
      halt 404
    else  
      ::Configuration.find(:application_id => a.id).sort.each {|c| config << c.to_hash}
      config.to_json
    end  
  end

  get '/c/?' do
    configs = []
    ::Configuration.all.sort.each {|c| configs << c.to_hash}
    if configs.empty?
      halt 404
    else  
      configs.to_json
    end  
  end

  put '/c/:appname/:element?' do |appname, element|
    app = ::Application.find_or_create(:name => appname)
    config = ::Configuration.find_or_create(:name => element, :application_id => app.id)
    required_params = ["format", "body"]
    data = JSON.parse(request.body.read)
    data.keys.sort == required_params.sort  ? (config.format = data["format"]; config.body = data["body"]) : (raise "Missing Parameters")
    if config.valid?
      config.save
      action = config.is_new? ? "create" : "update"
      dependency_action = app.is_new? ? "created" : "updated"
      r = {"result" => "success","id" => "#{config.id}", "action" => action, "dependencies" => dependency_action, "application" => app.name, "item" => config.name}
      r.to_json
    else
      raise "#{config.errors}"
    end
  end

  delete '/c/:appname/:element?' do |appname, element|
    app = ::Application.find(:name => appname).first
    if app
      config = ::Configuration.find(:name=> element, :application_id => app.id).first
      if config
        config.delete
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
