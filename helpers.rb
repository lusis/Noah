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
    h = Host.find(:name => hostname).first
    if h.nil?
      nil
    else  
      Service.find(:host_id => h.id, :name => servicename).first
    end  
  end

  def host_services(hostname)
    h = Host.find(:name => hostname).first
    if h.nil?
      nil
    else  
      Services.all(:host_id => id)
    end  
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
