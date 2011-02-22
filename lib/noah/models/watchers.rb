module Noah
  class Watcher < Model #NYI

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

  class Watchers
    def self.all(options = {})
      options.empty? ? Watcher.all.sort : Watcher.find(options).sort
    end
  end
end
