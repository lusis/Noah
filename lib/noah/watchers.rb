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
