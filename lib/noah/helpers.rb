module Noah
  module SinatraHelpers
    
    def format_errors(model)
      error_messages = model.errors.present do |e|
        # Missing attributes
        e.on [:name, :not_present], "Name attribute missing"
        e.on [:status, :not_present], "Status attribute missing"
        e.on [:format, :not_present], "Format attribute missing"
        e.on [:body, :not_present], "Body attribute missing"
        e.on [:application_id, :not_present], "Application attribute missing"
        e.on [:path, :not_present], "Path attribute missing"
        e.on [:pattern, :not_present], "Pattern attribute missing"
        e.on [:endpoint, :not_present], "Endpoint attribute missing"
        # Invalid option
        e.on [:status, :not_member], "Status must be up, down or pending"
        # Duplicate keys
        e.on [[:name, :application_id], :not_unique], "Record already exists"
        e.on [[:name, :host_id], :not_unique], "Record already exists"
        e.on [[:endpoint, :pattern], :not_unique], "Record already exists"
        e.on [:path, :not_unique], "Record already exists"
        # Custom exceptions
        e.on [:pattern, :already_provided], "Pattern is already provided"
        e.on [:pattern, :replaces_existing], "Pattern would overwrite existing"
      end
      error_messages.first
    end

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
