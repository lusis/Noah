module Noah

  class Service < Ohm::Model
    include Ohm::Typecast
    include Ohm::Timestamping
    include Ohm::Callbacks
    include Ohm::ExtraValidations

    attribute :name
    attribute :status
    reference :host, Host

    index :name
    index :status

    def validate
      assert_present :name
      assert_present :status
      assert_present :host_id
      assert_unique [:name, :host_id]
      assert_member :status, ["up", "down", "pending"]
    end

    def to_hash
      super.merge(:name => name, :status => status, :updated_at => updated_at, :host => Host[host_id].name)
    end

    def is_new?
      self.created_at == self.updated_at
    end

    class << self
    def find_or_create(opts = {})
      begin
        # convert passed host object to host_id if passed
        if opts.has_key?(:host)
          opts.merge!({:host_id => opts[:host].id})
          opts.reject!{|key, value| key == :host}
        end  
        # exclude requested status from lookup
        s = find(opts.reject{|key,value| key == :status}).first
        service = s.nil? ? create(opts) : s
        service.status = opts[:status]
        if service.valid?
          service.save
        end
        service
      rescue Exception => e
        e.message
      end
    end
    end
  end

  class Services
    def self.all(options = {})
      options.empty? ? Service.all.sort : Service.find(options).sort
    end
  end

end
