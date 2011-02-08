class Application < Ohm::Model
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks
  include Ohm::ExtraValidations

  attribute :name
  collection :configurations, Configuration

  index :name

  def validate
    assert_present :name
    assert_unique :name
  end

  def to_hash
    arr = []
    configurations.sort.each {|c| arr << c.to_hash}
    super.merge(:name => name, :updated_at => updated_at, :configurations => arr)
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
end

class Applications
  def self.all(options = {})
    options.empty? ? Application.all.sort : Application.find(options).sort
  end
end
