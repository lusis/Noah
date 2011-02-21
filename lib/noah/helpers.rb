module Noah
  module SinatraHelpers

    def host(opts = {})
      Noah::Host.find(opts).first
    end

    def hosts(opts = {})
      Noah::Hosts.all(opts)
    end

    def service(opts = {})
      Noah::Service.find(options)
    end

    def services(opts = {})
      Noah::Services.all(opts)
    end 

    def host_service(hostname, servicename)
      h = Noah::Host.find(:name => hostname).first
      if h.nil?
        nil
      else  
        Noah::Service.find(:host_id => h.id, :name => servicename).first
      end  
    end

    def host_services(hostname)
      h = Noah::Host.find(:name => hostname).first
      if h.nil?
        nil
      else  
        Noah::Services.all(:host_id => id)
      end  
    end 

    def application(opts = {})
      Noah::Application.find(opts).first
    end

    def applications(opts = {})
      Noah::Applications.all(opts)
    end

    def configuration(opts = {})
      Noah::Configuration.find(opts).first
    end

    def configurations(opts = {})
      Noah::Configurations.all(opts)
    end
  end

end
