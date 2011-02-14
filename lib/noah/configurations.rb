class Configuration < Ohm::Model
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks
  include Ohm::ExtraValidations

  attribute :name
  attribute :format
  attribute :body
  attribute :new_record
  reference :application, Application

  index :name
  index :format
  index :body

  after :save, :notify_via_redis_save
  after :create, :notify_via_redis_create
  after :update, :notify_via_redis_update
  before :delete, :stash_name
  after :delete, :notify_via_redis_delete

  def validate
    super
    assert_present :name
    assert_present :format
    assert_present :body
    assert_unique [:name, :application_id]
  end

  def to_hash
    application.nil? ? app=nil : app=Application[application_id].name
    super.merge(:name => name, :format => format, :body => body, :created_at => created_at, :updated_at => updated_at, :application => app)
  end

  def is_new?
    self.created_at == self.updated_at
  end

  class << self
  def find_or_create(opts={})
    begin
      if find(opts).first.nil?
        conf = create(opts)
      else  
        conf = find(opts).first
      end  
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
        pub_category = "noah.#{self.class.to_s}[#{self.name ||= @deleted_name}].#{meth}"
        Ohm.redis.publish(pub_category, self.to_json)
      end
    end
  end
end

class Configurations
  def self.all(options = {})
    options.empty? ? Configuration.all.sort : Configuration.find(options).sort
  end
end 
