require File.join(File.dirname(__FILE__), 'configurations')
module Noah
  class Application < Model
    include Taggable
    attribute :name
    set :configurations, Configuration

    index :name

    def validate
      super
      assert_present :name
      assert_unique :name
    end

    def to_hash
      arr = []
      self.configurations.sort.each {|c| arr << c.to_hash} if self.configurations.size != 0
      super.merge(:name => name, :configurations => arr, :created_at => created_at, :updated_at => updated_at)
    end

    class << self
    def find_or_create(opts = {})
      begin
        find(opts).first.nil? ? (obj = new(opts)) : (obj = find(opts).first)
        if obj.valid?
          obj.save
        end
        obj
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
end
