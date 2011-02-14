class Application < Ohm::Model
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks
  include Ohm::ExtraValidations

  attribute :name
  collection :configurations, Configuration

  index :name

  after :save, :notify_via_redis_save
  after :create, :notify_via_redis_create
  after :update, :notify_via_redis_update
  before :delete, :stash_name
  after :delete, :notify_via_redis_delete

  def validate
    super
    assert_present :name
    assert_unique :name
  end

  def to_hash
    arr = []
    configurations.sort.each {|c| arr << c.to_hash}
    super.merge(:name => name, :created_at => created_at, :updated_at => updated_at, :configurations => arr)
  end

  def is_new?
    self.created_at == self.updated_at
  end

  class << self
  def find_or_create(opts = {})
    begin
      find(opts).first.nil? ? (app = create(opts)) : (app = find(opts).first)
      if app.valid?
        app.save
      end
      app
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

class Applications
  def self.all(options = {})
    options.empty? ? Application.all.sort : Application.find(options).sort
  end
end
