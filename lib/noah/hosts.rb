class Host < Ohm::Model
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks
  include Ohm::ExtraValidations

  attribute :name
  attribute :status
  collection :services, Service

  index :name
  index :status

  after :create, :notify_via_redis
  after :update, :notify_via_redis

  def validate
    assert_present :name
    assert_present :status
    assert_unique :name
    assert_member :status, ["up","down","pending"]
  end

  def to_hash
    arr = []
    services.sort.each {|s| arr << s.to_hash}
    h = {:name => name, :status => status, :created_at => created_at, :updated_at => updated_at, :services => arr}
    super.merge(h)
  end

  def is_new?
    self.created_at == self.updated_at
  end

  class << self
  def find_or_create(opts = {})
    begin
      # exclude requested status from lookup
      h = find(opts.reject{|key,value| key == :status}).first
      host = h.nil? ? create(opts) : h
      host.status = opts[:status]
      if host.valid?
        host.save
      end
      host
    rescue Exception => e
      e.message
    end
  end
  end

  protected
  def notify_via_redis
    msg = self.to_hash.merge({:class => self.class})
    Ohm.redis.publish(:noah, msg.to_json)
  end
end

class Hosts
  def self.all(options = {})
    options.empty? ? Host.all.sort : Host.find(options).sort
  end
end
