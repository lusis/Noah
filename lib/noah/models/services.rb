module Noah

  class Service < Model
    include Taggable
    include Linkable
    attribute :name
    attribute :status
    attribute :data
    reference :host, Host

    index :name
    index :status

    def validate
      super
      assert_present :name
      assert_present :status
      assert_present :host_id
      assert_unique [:name, :host_id]
      assert_member :status, ["up", "down", "pending"]
    end

    def to_hash
      Host[host_id].nil? ? host_name=nil : host_name=Host[host_id].name
      super.merge(:name => name, :status => status, :updated_at => updated_at, :host => host_name, :data => data)
    end

    class << self
      def find_or_create(opts = {})
        # convert passed host object to host_id if passed
        if opts.has_key?(:host)
          opts.merge!({:host_id => opts[:host].id})
          opts.reject!{|key, value| key == :host}
        end  
        # exclude requested status from lookup
        s = find(:name => opts[:name], :host_id => opts[:host_id]).first
        s.nil? ? service=new(opts) : service=s
        service.status = opts[:status]
        service.data = opts[:data]
        if service.valid?
          service.save
        end
        service
      end
    end
  end

  class Services
    def self.all(options = {})
      service_hash = Hash.new
      options.empty? ? services=Service.all.sort : services=Service.find(options).sort
      services.each do |svc|
        service_hash["#{svc.name}"] = Hash.new unless service_hash.has_key?(svc.name)
        host_name = Noah::Host[svc.host_id].name
        service_hash["#{svc.name}"]["#{host_name}"] = Hash.new
        service_hash["#{svc.name}"]["#{host_name}"].merge!({:id => svc.id, :status => svc.status, :data => svc.data, :tags => svc.to_hash[:tags], :links => svc.to_hash[:links], :created_at => svc.created_at, :updated_at => svc.updated_at})
      end
      service_hash
    end
  end
end
