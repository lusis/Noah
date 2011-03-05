require 'digest/sha1'
module Noah
  class Watcher < Model #NYI
    # Don't trust anything in here yet
    # I'm still trying a few things
    include WatcherValidations

    attribute :pattern
    attribute :endpoint

    index :pattern
    index :endpoint

    def validate
      super
      assert_present :endpoint
      assert_present :pattern
      assert_unique [:endpoint, :pattern]
      assert_not_superset
      assert_not_subset
    end

    def name
      @name = Digest::SHA1.hexdigest "#{endpoint}#{pattern}"
    end

    def to_hash
      h = {:pattern => pattern, :endpoint => endpoint, :created_at => created_at, :updated_at => updated_at}
      super.merge(h)
    end

    def self.watch_list
      hsh = Hash.new
      watch_list = self.all.sort_by(:pattern)
      watch_list.each do |watch|
        p = watch.pattern.to_sym
        e = watch.endpoint
        if hsh.has_key?(p)
          hsh[p].push(watch.endpoint)
        else
          hsh[p] = Array.new
          hsh[p].push(watch.endpoint)
        end
      end
      hsh
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
