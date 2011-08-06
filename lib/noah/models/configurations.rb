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
        find(:name => opts[:name]).first.nil? ? (obj = new(opts)) : (obj = find(:name => opts[:name]).first)
        if obj.valid? && obj.new?
          obj.save
        else
          obj.format = opts[:format]
          obj.body = opts[:body]
          obj.save if obj.valid?
        end
        obj
      rescue Exception => e
        e.message
      end
    end
    end

  end

  class Configurations
    def self.all(options = {}, short=false)
      short_keys = [:format, :created_at, :updated_at]
      config_hash = Hash.new
      options.empty? ? configs=Configuration.all.sort : configs=Configuration.find(options).sort
      if short == false
        configs.each {|x| config_hash["#{x.name}"] = x.to_hash.reject {|k,v| k == :name} }
      else
        configs.each do |x|
          items = x.to_hash.select {|k,v| k if short_keys.include?(k)}
          # 1.8 fix for Hash#select
          if items.is_a?(Array)
            items_hash = {}
            items.each {|item| items_hash.merge!(Hash[*item])}
          else
            items_hash = items
          end
          config_hash["#{x.name}"] = items_hash
        end
      end
      config_hash
    end
  end 
end
