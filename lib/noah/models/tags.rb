module Noah
  class Tag < Model
    attribute :name
    index :name

    def validate
      super
      assert_present :name
      assert_unique :name
    end

    def tagged(tag)
      # TODO:
      #logic to find all models with a given tag
      #will need hooks added to taggable module
    end

    class <<self
    def find_or_create(opts={})
      begin
        find(opts).first.nil? ? obj=new(opts) : obj=find(opts).first
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

end
