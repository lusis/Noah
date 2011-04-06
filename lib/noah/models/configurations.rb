require File.join(File.dirname(__FILE__), 'applications')
module Noah
  class Configuration < Model

    attribute :name
    attribute :format
    attribute :body

    index :name
    index :format
    index :body

    def validate
      super
      assert_present :name
      assert_present :format
      assert_present :body
      assert_unique :name
    end

    def to_hash
      super.merge(:name => name, :format => format, :body => body, :created_at => created_at, :updated_at => updated_at)
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

  class Configurations
    def self.all(options = {})
      options.empty? ? Configuration.all.sort : Configuration.find(options).sort
    end
  end 
end
