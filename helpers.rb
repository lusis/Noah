helpers do
  def host(opts = {})
    Host.find(opts).first
  end

  def hosts(opts = {})
    Hosts.all(opts)
  end

  def service(opts = {})
    Service.find(options)
  end

  def services(opts = {})
    Services.all(opts)
  end 

  def host_service(hostname, servicename)
    id = Host.find(:name => hostname).first.id
    Service.find(:host_id => id, :name => servicename).first
  end

  def host_services(hostname)
    id = Host.find(:name => hostname).first.id
    Services.all(:host_id => id)
  end 

  def application(opts = {})
    Application.find(opts).first
  end

  def applications(opts = {})
    Applications.all(opts)
  end

  def configuration(opts = {})
    Configuration.find(opts).first
  end

  def configurations(opts = {})
    Configurations.all(opts)
  end  
end
