class Noah::App
# Host URIs

  # GET named {Service} for named {Host}
  get '/h/:hostname/:servicename/?' do |hostname, servicename|
    h = host_service(hostname, servicename)
    if h.nil?
      halt 404
    else
      h.to_json
    end
  end

  # GET named {Host}
  # @param :hostname name of {Host}
  # @return [JSON] representation of {Host}
  get '/h/:hostname/?' do |hostname|
    h = host(:name => hostname)
    if h.nil?
      halt 404
    else
      h.to_json
    end
  end

  # GET all {Hosts}
  get '/h/?' do
    hosts.map {|h| h.to_hash}
    if hosts.size == 0
      halt 404
    else
      hosts.to_json
    end
  end

  put '/h/:hostname/watch' do |hostname|
    required_params = ["endpoint"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (h = Noah::Host.find(:name => hostname).first) : (raise "Missing Parameters")
    h.nil? ? (halt 404) : (w = h.watch!(:endpoint => data['endpoint']))
    w.to_json
  end

  put '/h/:hostname/?' do |hostname|
    required_params = ["name", "status"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort && data['name'] == hostname) ? (host = Noah::Host.find_or_create(:name => data['name'], :status => data['status'])) : (raise "Missing Parameters")
    if host.valid?
      r = {"result" => "success","id" => "#{host.id}","status" => "#{host.status}", "name" => "#{host.name}", "new_record" => host.is_new?}
      r.to_json
    else
      raise "#{format_errors(host)}"
    end
  end

  delete '/h/:hostname/?' do |hostname|
    host = Noah::Host.find(:name => hostname).first
    if host
      services = []
      Noah::Service.find(:host_id => host.id).sort.each {|x| services << x; x.delete} if host.services.size > 0
      host.delete
      r = {"result" => "success", "id" => "#{host.id}", "name" => "#{hostname}", "service_count" => "#{services.size}"}
      r.to_json
    else
      halt 404
    end
  end

end
