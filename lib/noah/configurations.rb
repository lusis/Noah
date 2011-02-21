module Noah
  class Configuration < Model

    attribute :format
    attribute :body
    attribute :new_record
    reference :application, Application

    index :format
    index :body

    def validate
      super
      assert_present :format
      assert_present :body
      assert_present :application_id
      assert_unique [:name, :application_id]
    end

    def to_hash
      Application[application_id].nil? ? app_name=nil : app_name=Application[application_id].name
      super.merge(:name => name, :format => format, :body => body, :created_at => created_at, :updated_at => updated_at, :application => app_name)
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
