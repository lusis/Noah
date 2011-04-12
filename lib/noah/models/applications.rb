require File.join(File.dirname(__FILE__), 'configurations')
module Noah
  class Application < Model
    include Taggable
    include Linkable
    attribute :name
    set :configurations, Configuration

    index :name

    def validate
      super
      assert_present :name
      assert_unique :name
    end

    def to_hash
      cfg_hash = Hash.new
      configurations.sort.each do |cfg|
        cfg_hash["#{cfg.name}"] = {:format => cfg.to_hash[:format], :body => cfg.to_hash[:body]}
      end
      {name => {:id => id, :created_at => created_at, :updated_at => updated_at, :configurations => cfg_hash}}
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
      app_hash = Hash.new
      options.empty? ? apps=Application.all.sort : apps=Application.find(options).sort
      apps.each {|x| app_hash["#{x.name}"] = x.to_hash.reject {|k,v| k == :name} }
      app_hash
    end
  end
end
