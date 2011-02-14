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

  after :save, :notify_via_redis_save
  after :create, :notify_via_redis_create
  after :update, :notify_via_redis_update
  before :delete, :stash_name
  after :delete, :notify_via_redis_delete

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
    super.merge(:name => name, :status => status, :updated_at => updated_at, :host => host_name)
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

  protected
  def stash_name
    @deleted_name = self.name
  end

  ["save", "create", "update", "delete"].each do |meth|
    class_eval do
      define_method("notify_via_redis_#{meth}".to_sym) do
        self.name.nil? ? name=@deleted_name : name=self.name
        pub_category = "noah.#{self.class.to_s}[name].#{meth}"
        Ohm.redis.publish(pub_category, self.to_json)
      end
    end
  end
end

class Services
  def self.all(options = {})
    options.empty? ? Service.all.sort : Service.find(options).sort
  end
end
