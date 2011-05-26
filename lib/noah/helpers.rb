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
        e.on [:path, :reserved_path], "Path is reserved"
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

    def find_hosts_by_service(servicename)
      affected_hosts = []
      s = Noah::Service.find(:name => servicename)
      if s.nil?
        affected_hosts
      else
        Noah::Host.all.each {|x| affected_hosts << x if (x.services.to_a & s.to_a).length > 0}
        affected_hosts
      end
    end

    def delete_service_from_host(servicename, hostname)
      host = Noah::Host.find(:name => hostname).first
      (halt 404) if host.nil?
      service = Noah::Service.find(:name => servicename, :host_id => host.id).first
      (halt 404) if service.nil?
      service.delete
      r = {"action" => "delete", "result" => "success", "id" => service.id, "host" => host.name, "service" => servicename}
      r.to_json
    end

    def find_named_link(path)
      link = Noah::Link.find(:path => "/"+path).first
      if link.nil?
        # try finding it wihtout the slash
        link = Noah::Link.find(:path => path).first
        (halt 404) if link.nil?
      end
      return link
    end

    def add_config_to_app(appname, config_hash)
      begin
        config = Noah::Configuration.find_or_create(config_hash)
        if config.valid?
          dep_action = config.is_new? ? "create" : "update"
        else
          raise "#{format_errors(config)}"
        end
        app = Noah::Application.find_or_create(:name => appname)
        if app.valid?
          action = app.is_new? ? "create" : "update"
          app.configurations << config
          r = {"result" => "success", "id" => "#{app.id}", "name" => "#{app.name}", "action" => action, "configuration" => {"action" => dep_action, "id" => "#{config.id}", "item" => "#{config.name}"}}
          r.to_json
        else
          raise "#{format_errors(app)}"
        end
      rescue Exception => e
        e.message
      ensure
        # Clean up partial objects
        app.delete if app.valid? == false
        config.delete if config.valid? == false
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
