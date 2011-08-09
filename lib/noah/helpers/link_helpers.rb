module Noah
  module SinatraLinkHelpers

    def link(primitive, name, link)
      case primitive
      when "services"
        servicename, hostname = name.split('/')
        obj = host_service(hostname, servicename)
      when 'hosts'
        obj = Noah::Host.find(:name=>name).first
      when 'configurations'
        obj = Noah::Configuration.find(:name=>name).first
      when 'applications'
        obj = Noah::Application.find(:name=>name).first
      when 'ephemerals'
        obj = Noah::Ephemeral.find(:path=>"/#{name}").first
      else
        halt 404
      end
      obj.nil? ? (halt 404) : (obj.link! link)
      obj.to_json
    end

    def unlink(primitive, name, link)
      case primitive
      when "services"
        servicename, hostname = name.split('/')
        obj = host_service(hostname, servicename)
      when "hosts"
        obj = Noah::Host.find(:name=>name).first
      when "configurations"
        obj = Noah::Configuration.find(:name=>name).first
      when "applications"
        obj = Noah::Application.find(:name=>name).first
      when "ephemerals"
        obj = Noah::Ephemeral.find(:path=>"/#{name}").first
      else
        halt 404
      end
      obj.nil? ? (halt 404) : (obj.unlink! link)
      obj.to_json
    end

  end
end
