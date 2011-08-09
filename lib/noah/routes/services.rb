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

  put '/services/:servicename/watch' do |servicename|
    required_params = ["endpoint"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (s = Noah::Service.find(:name => servicename).first) : (raise "Missing Parameters")
    s.nil? ? (halt 404) : (w = s.watch!(:endpoint => data['endpoint']))
    w.to_json
  end

  put '/services/:servicename/:hostname?' do |servicename, hostname|
    required_params = ["status", "host_status"]
    data = JSON.parse(request.body.read)
    raise ("Missing Parameters") if data.nil?
    if data.keys.sort == required_params.sort
      begin
        host = Noah::Host.find_or_create(:name => hostname, :status => data['host_status'])
        if host.valid?
          service = Noah::Service.find_or_create(:name => servicename, :status => data['status'], :host => host)
          if service.valid?
            service_action = service.is_new? ? "create" : "update"
            host_action = host.is_new? ? "create" : "update"
            r = {"action" => service_action, "result" => "success", "id" => service.id, "name" => service.name, "host" => {"name" => host.name, "action" => host_action, "status" => host.status}}
            r.to_json
          else
            raise "#{format_errors(service)}"
          end
        else
          raise "#{format_errors(host)}"
        end
      end
    else
      raise "Missing Parameters"
    end  
  end

  delete '/services/:servicename/:hostname/?' do |servicename, hostname|
    delete_service_from_host(servicename, hostname)
  end

  delete '/services/:servicename/?' do |servicename|
    affected_hosts = find_hosts_by_service(servicename)
    (halt 404) if affected_hosts.size == 0
    service = Noah::Service.find(:name => servicename)
    service.each {|x| x.delete}
    r = {"action" => "delete", "result" => "success", "affected_hosts" => affected_hosts.size, "service" => servicename}
    r.to_json
  end
end
