require 'ohm/contrib'

class Host < Ohm::Model
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks

  attribute :name
  attribute :state, Boolean
  collection :services, Service

  index :name
  index :state

  def validate
    assert_present :name, :state
    assert_unique :name
  end

  def to_hash
    arr = []
    services.sort.each {|s| arr << s.to_hash}
    super.merge(:name => name, :state => state, :updated_at => updated_at, :services => arr)
  end

end

class Service < Ohm::Model
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks

  attribute :name
  attribute :state, Boolean
  reference :host, Host

  index :name
  index :state

  def validate
    assert_present :name, :state
    assert_unique [:name, :host_id]
  end

  def to_hash
    super.merge(:name => name, :state => state, :updated_at => updated_at, :host => Host[host_id].name)
  end
end

class Configuration < Ohm::Model
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks

  attribute :name
  attribute :format
  attribute :body
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
end

class Application < Ohm::Model
  include Ohm::Typecast
  include Ohm::Timestamping
  include Ohm::Callbacks

  attribute :name
  collection :configurations, Configuration

  index :name

  def validate
    assert_present :name
    assert_unique :name
  end

  def to_hash
    super.merge(:name => name, :updated_at => updated_at)
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
