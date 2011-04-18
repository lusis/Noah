require File.join(File.dirname(__FILE__), 'applications')
module Noah
  class Configuration < Model
    include Taggable
    include Linkable
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

    # Because we're not doing a 2-way relationship
    # we need to clean up any applications that use 
    # this configuration ourself
    def delete
      @affected_applications = Array.new
      Noah::Application.all.each do |app|
        if app.configurations.member?(self)
          app.configurations.delete(self)
          @affected_applications << app.name
        end
      end
      super
    end

    def affected_applications
      @affected_applications
    end

    class << self
    def find_or_create(opts={})
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

  class Configurations
    def self.all(options = {})
      config_hash = Hash.new
      options.empty? ? configs=Configuration.all.sort : configs=Configuration.find(options).sort
      configs.each {|x| config_hash["#{x.name}"] = x.to_hash.reject {|k,v| k == :name} }
      config_hash
    end
  end 
end
