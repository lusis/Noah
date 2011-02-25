module Noah
  class Watcher < Model #NYI
    # This is a "special rainbow" of a class

    attribute :client
    attribute :pattern
    attribute :endpoint

    index :client
    index :pattern
    index :endpoint

    def validate
      super
      assert_present :client, :endpoint, :pattern
      assert_unique [:client, :endpoint, :pattern]
    end
  end

  class Watchers
    def self.all(options = {})
      options.empty? ? Watcher.all.sort : Watcher.find(options).sort
    end
  end
end
