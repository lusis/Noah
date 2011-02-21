require 'ohm'
require 'ohm/contrib'
module Noah
  class Model < Ohm::Model
    def self.inherited(model)

      model.send :include, Ohm::Timestamping
      model.send :include, Ohm::Typecast
      model.send :include, Ohm::Callbacks
      model.send :include, Ohm::ExtraValidations

      model.attribute :name
      model.index :name
      model.after :save, :notify_via_redis_save
      model.after :create, :notify_via_redis_create
      model.after :update, :notify_via_redis_update
      model.before :delete, :stash_name
      model.after :delete, :notify_via_redis_delete
      model.send :include, ModelClassMethods
    end
  end

  module ModelClassMethods
    def validate
      super
      assert_present :name
    end

    def is_new?
      self.created_at == self.updated_at
    end

    protected
    def stash_name
      @deleted_name = self.name
    end

    ["save", "create", "update", "delete"].each do |meth|
      class_eval do
        define_method("notify_via_redis_#{meth}".to_sym) do
          self.name.nil? ? name=@deleted_name : name=self.name
          pub_category = "noah.#{self.class.to_s}[name].#{meth}"
          Ohm.redis.publish(pub_category, self.to_json)
        end
      end
    end

  end
end
require File.join(File.dirname(__FILE__), 'hosts')
require File.join(File.dirname(__FILE__), 'services')
require File.join(File.dirname(__FILE__), 'applications')
require File.join(File.dirname(__FILE__), 'configurations')
require File.join(File.dirname(__FILE__), 'watchers')
