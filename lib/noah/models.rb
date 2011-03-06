require 'ohm'
require 'ohm/contrib'
module Noah
  class Model < Ohm::Model
    def self.inherited(model)

      model.send :include, Ohm::Timestamping
      model.send :include, Ohm::Typecast
      model.send :include, Ohm::Callbacks
      model.send :include, Ohm::ExtraValidations

      # removing this as it's simply redundant
      # model.after :save, :notify_via_redis_save
      model.after :create, :notify_via_redis_create
      model.after :update, :notify_via_redis_update
      model.before :delete, :stash_name
      model.after :delete, :notify_via_redis_delete
      model.send :include, ModelClassMethods
    end
  end

  module ModelClassMethods

    def is_new?
      self.created_at == self.updated_at
    end


    def watch!(opts={:endpoint => nil, :pattern => nil})
      # TODO: There's still a condition here for duplicate watches
      # i.e. User already has a wildcard for that endpoint and adds a more narrow scope
      # need to handle that either here or in the watcher class
      base_pattern = "#{self.patternize_me}."
      opts[:endpoint].nil? ? (raise ArgumentError, "Need an endpoint") : endpoint=opts[:endpoint]
      opts[:pattern].nil? ? pattern=base_pattern+"*" : pattern=base_pattern+opts[:pattern]

      begin
        w = Watcher.new :pattern => pattern, :endpoint => endpoint
        w.valid? ? w.save : (raise "#{w.errors}")
        w.name
      rescue Exception => e
        e.message
      end
    end
      
    protected
    def patternize_me
      "//noah/#{self.class_to_lower}/#{name.gsub(/^\//,'')}"
    end

    def stash_name
      @deleted_name = self.name
    end

    def class_to_lower
      self.class.to_s.gsub(/(.*)::(\w)/,'\2').downcase
    end
    def dbnum
      o = Ohm.options.first
      return "0" if o.nil?
      return "0" if (o[:db].nil? && o[:url].nil?)
      o[:db].nil? ? "#{o[:url].split('/').last}" : "#{o[:db]}"
    end

    ["create", "update", "delete"].each do |meth|
      class_eval do
        define_method("notify_via_redis_#{meth}".to_sym) do
          db = self.dbnum
          self.name.nil? ? name=@deleted_name : name=self.name
          # Pulling out dbnum for now. Need to rethink it
          #pub_category = "#{db}:noah.#{self.class.to_s}[#{name}].#{meth}"
          pub_category = "#{self.patternize_me}"
          Ohm.redis.publish(pub_category, self.to_hash.merge({"action" => meth, "pubcategory" => pub_category}).to_json)

          # The following provides a post post-action hook. It allows a class to provide it's own handling after the fact
          # good example is in [Noah::Ephemeral] where it's used to check for/clean up expired ephemeral nodes entries
          self.send("#{meth}_hook".to_sym) unless self.protected_methods.member?("#{meth}_hook".to_sym) == false
        end
      end
    end

  end
end
require File.join(File.dirname(__FILE__), 'models','hosts')
require File.join(File.dirname(__FILE__), 'models','services')
require File.join(File.dirname(__FILE__), 'models','applications')
require File.join(File.dirname(__FILE__), 'models','configurations')
require File.join(File.dirname(__FILE__), 'models','watchers')
require File.join(File.dirname(__FILE__), 'models','ephemerals')
