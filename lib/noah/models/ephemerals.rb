require 'digest/sha1'
module Noah
  class Ephemeral < Model #NYI

    attribute :path
    attribute :data

    index :path

    def validate
      super
      assert_present :path
      assert_unique :path
    end

    def name
      @name = path
    end

    protected
    def save_hook
      # called after any create,update,delete
      # logic needed to expire any orphaned ephemerals
    end

    private
    def path_protected?(path_part)
      # Check for protected paths in ephemeral nodes
    end
      
  end

end
