class Noah::App
  content_type_mapping = {
            :yaml => "text/x-yaml",
            :json => "application/json",
            :xml => "text/xml",
            :string => "text/plain"
  }
  get '/configurations/:configname/?', :provides => :json do |configname|
    c = Noah::Configuration.find(:name => configname).first
    (halt 404) if c.nil?
    c.to_json
  end
  get '/configurations/:configname/?' do |configname|
    c = Noah::Configuration.find(:name => configname).first
    (halt 404) if c.nil?
    content_type content_type_mapping[c.format.to_sym] if content_type_mapping[c.format.to_sym]
    c.body
  end

  # GET all configurations
  get '/configurations/?' do
    params[:short] ||= false
    configs = Noah::Configurations.all({},params[:short])
    (halt 404) if configs.size == 0
    configs.each do |config, values|
      u = request.url.gsub(/(\/\?short=true|\?short=true)/,'/'+config)
      values.merge!({:location=>u}) if params[:short]
    end
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

  # Add a watch to a configuration object
  put '/configurations/:configname/watch' do |configname|
    required_params = ["endpoint"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (c = Noah::Configuration.find(:name => configname).first) : (raise "Missing Parameters")
    c.nil? ? (halt 404) : (w = c.watch!(:endpoint => data['endpoint']))
    w.to_json
  end
  # Attach a configuration object to an application object
  put '/configurations/:configname/?' do |configname|
    required_params = ["format", "body"]
    data = JSON.parse(request.body.read)
    data.keys.sort == required_params.sort ? config=Noah::Configuration.find_or_create(:name => configname) : (raise "Missing Parameters")
    config.body = data["body"]
    config.format = data["format"]
    if config.valid?
      config.save
      action = config.is_new? ? "create" : "update"
      r = {"result" => "success","id" => "#{config.id}", "action" => action, "item" => config.name}
      r.to_json
    else
      raise "#{format_errors(config)}"
    end
  end

  delete '/configurations/:configname/?' do |configname|
    cfg = Noah::Configuration.find(:name => configname).first
    (halt 404) if cfg.nil?
    cfg.delete
    r = {"result" => "success", "id" => cfg.id, "action" => "delete", "affected_applications" => cfg.affected_applications, "item" => cfg.name}
    r.to_json
  end
end
