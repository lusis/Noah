require 'ohm/contrib'

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

  def validate
    assert_present :name
    assert_present :status
    assert_unique :name
    assert_member :status, ["up","down","pending"]
  end

  def to_hash
    arr = []
    services.sort.each {|s| arr << s.to_hash}
    super.merge(:name => name, :status => status, :updated_at => updated_at, :services => arr)
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
        host 
      else
        raise host.errors
      end
    rescue Exception => e
      e.message
    end
  end
  end
end

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
    assert_present :name, :status
    assert_unique [:name, :host_id]
    assert_member :status, ["up", "down", "pending"]
  end

  def to_hash
    super.merge(:name => name, :status => status, :updated_at => updated_at, :host => Host[host_id].name)
  end

  def is_new?
    self.created_at == self.updated_at
  end
end

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

  def validate
    assert_present :name
    assert_present :format
    assert_present :body
    assert_unique [:name, :application_id]
  end

  def to_hash
    super.merge(:name => name, :format => format, :body => body, :update_at => updated_at, :application => Application[application_id].name)
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
end

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
        app
      else
        raise app.errors
      end
    rescue Exception => e
      e.message
    end
  end
  end
end

class Watcher < Ohm::Model #NYI
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks

  attribute :client
  attribute :endpoint
  attribute :event
  attribute :action 

  index :client
  index :event

  def validate
    assert_present :client, :endpoint, :event, :action
    assert_unique [:client, :endpoint, :event, :action]
  end
end

# Some pluralized helper models
class Hosts
  def self.all(options = {})
    options.empty? ? Host.all.sort : Host.find(options).sort
  end
end

class Services
  def self.all(options = {})
    options.empty? ? Service.all.sort : Service.find(options).sort
  end
end

class Applications
  def self.all(options = {})
    options.empty? ? Application.all.sort : Application.find(options).sort
  end
end

class Configurations
  def self.all(options = {})
    options.empty? ? Configuration.all.sort : Configuration.find(options).sort
  end
end  
