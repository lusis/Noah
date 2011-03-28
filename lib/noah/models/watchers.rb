require 'digest/sha1'
module Noah
  class Watcher < Model
    include WatcherValidations

    attribute :pattern
    attribute :endpoint
    attribute :name

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
      @name = Base64.encode64("#{pattern}|#{endpoint}").gsub("\n","")
    end

    def to_hash
      h = {:pattern => pattern, :name => name, :endpoint => endpoint, :created_at => created_at, :updated_at => updated_at}
      super.merge(h)
    end

    class << self
    def find_by_name(name)
      pattern, endpoint = Base64.decode64(name).split('|')
      find(:pattern => pattern, :endpoint => endpoint).first
    end

    def watch_list
      arr = []
      watches = self.all.sort_by(:pattern)
      watches.each {|w| arr << w.to_hash}
      arr
    end
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
    @@agents = []
    def self.all(options = {})
      options.empty? ? Watcher.all.sort : Watcher.find(options).sort
    end

    def self.register_agent(agent_class)
      @@agents << agent_class
    end

    def self.agents
      @@agents
    end
  end
end
