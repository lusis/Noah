require 'digest/sha1'
module Noah
  class Watcher < Model #NYI
    # Don't trust anything in here yet
    # I'm still trying a few things

    attribute :pattern
    attribute :endpoint

    index :pattern
    index :endpoint

    def validate
      super
      assert_present :endpoint
      assert_present :pattern
      assert_unique [:endpoint, :pattern]
    end

    def name
      @name = Digest::SHA1.hexdigest "#{endpoint}#{pattern}"
    end

    private
    # Not sure about these next two.
    # Could get around patterns changing due to namespace changes
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
