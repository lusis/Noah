class Noah::App
  # Service URIs

  # get named {Service} for named {Host}
  get '/services/:servicename/:hostname/?' do |servicename, hostname|
    hs = host_service(hostname, servicename)
    if hs.nil?
      halt 404
    else  
      hs.to_json
    end  
  end

  get '/services/:servicename/?' do |servicename|
    s = services(:name => servicename)
    (halt 404) if s.size == 0
    s.to_json
  end

  get '/services/?' do
    (halt 404) if services.size == 0
    services.to_json
  end

  put '/services/:servicename/:hostname/tag' do |servicename, hostname|
    required_params = ["tags"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (a=host_service(hostname, servicename)) : (raise "Missing Parameters")
    a.nil? ? (halt 404) : (a.tag!(data['tags']))
    a.to_json
  end

  put '/services/:servicename/watch' do |servicename|
    required_params = ["endpoint"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (s = Noah::Service.find(:name => servicename).first) : (raise "Missing Parameters")
    s.nil? ? (halt 404) : (w = s.watch!(:endpoint => data['endpoint']))
    w.to_json
  end

  put '/services/:servicename/?' do |servicename|
    required_params = ["status", "host", "name"]
    data = JSON.parse(request.body.read)
    if data.keys.sort == required_params.sort
      h = Noah::Host.find(:name => data['host']).first || (raise "Invalid Host")
      service = Noah::Service.find_or_create(:name => servicename, :status => data['status'], :host => h)
      if service.valid?
        action = service.is_new? ? "create" : "update"
        service.save
        r = {"action" => action, "result" => "success", "id" => service.id, "host" => h.name, "name" => service.name}
        r.to_json
      else
        raise "#{format_errors(service)}"
      end
    else
      raise "Missing Parameters"
    end  
  end

  delete '/services/:servicename/:hostname/?' do |servicename, hostname|
    host = Noah::Host.find(:name => hostname).first || (halt 404)
    service = Noah::Service.find(:name => servicename, :host_id => host.id).first || (halt 404)
    if host && service
      service.delete
      r = {"action" => "delete", "result" => "success", "id" => service.id, "host" => host.name, "service" => servicename}
      r.to_json
    else
      halt 404
    end  
  end  
end
