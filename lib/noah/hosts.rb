class Host < Ohm::Model
  # Host model
  # @return {Host} a {Host} object
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks
  include Ohm::ExtraValidations

  attribute :name
  attribute :status
  collection :services, Service

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
    assert_unique :name
    assert_member :status, ["up","down","pending"]
  end

  # @return [Hash] A hash representation of a {Host}
  def to_hash
    arr = []
    services.sort.each {|s| arr << s.to_hash}
    h = {:name => name, :status => status, :created_at => created_at, :updated_at => updated_at, :services => arr}
    super.merge(h)
  end

  # Evaluate if {Host} record is new or not
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
  # Saves the original {Host#name} attribute before deleting an object
  def stash_name
    @deleted_name = self.name
  end

  ["save", "create", "update", "delete"].each do |meth|
    class_eval do
      define_method("notify_via_redis_#{meth}".to_sym) do
        self.name.nil? ? name=@delete_name : name=self.name
        pub_category = "noah.#{self.class.to_s}[#{name}].#{meth}"
        Ohm.redis.publish(pub_category, self.to_json)
      end
    end
  end
end

class Hosts
  # @param [Hash] optional filters for results
  # @return [Array] Array of {Host} objects
  def self.all(options = {})
    options.empty? ? Host.all.sort : Host.find(options).sort
  end
end
