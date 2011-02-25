require 'ohm'
require 'ohm/contrib'
module Noah
  class Model < Ohm::Model
    def self.inherited(model)

      model.send :include, Ohm::Timestamping
      model.send :include, Ohm::Typecast
      model.send :include, Ohm::Callbacks
      model.send :include, Ohm::ExtraValidations

      model.after :save, :notify_via_redis_save
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

    protected
    def stash_name
      @deleted_name = self.name
    end

    def dbnum
      o = Ohm.options.first
      return "0" if o.nil?
      return "0" if (o[:db].nil? && o[:url].nil?)
      o[:db].nil? ? "#{o[:url].split('/').last}" : "#{o[:db]}"
    end

    ["save", "create", "update", "delete"].each do |meth|
      class_eval do
        define_method("notify_via_redis_#{meth}".to_sym) do
          db = self.dbnum
          self.name.nil? ? name=@deleted_name : name=self.name
          # Pulling out dbnum for now. Need to rethink it
          #pub_category = "#{db}:noah.#{self.class.to_s}[#{name}].#{meth}"
          pub_category = "noah.#{self.class.to_s}.#{name}.#{meth}"
          Ohm.redis.publish(pub_category, self.to_hash.merge({"action" => meth, "pubcategory" => pub_category}).to_json)
          # self.method_defined? "#{meth}_hook".to_sym
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
require File.join(File.dirname(__FILE__), 'models','epehmerals')
