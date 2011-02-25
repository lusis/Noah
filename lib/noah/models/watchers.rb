require 'digest/sha1'
module Noah
  class Watcher < Model #NYI
    # Don't trust anything in here yet
    # I'm still trying a few things

    attribute :client
    attribute :pattern
    attribute :endpoint

    index :client
    index :pattern
    index :endpoint

    def validate
      super
      assert_present :client
      assert_present :endpoint
      assert_present :pattern
      assert_unique [:client, :endpoint, :pattern]
    end

    def name
      @name = Digest::SHA1.hexdigest "#{client}#{endpoint}#{pattern}"
    end

    private
    def path_to_pattern 
    end

    def pattern_to_path
    end
  end

  class Watchers
    def self.all(options = {})
      options.empty? ? Watcher.all.sort : Watcher.find(options).sort
    end
  end
end
