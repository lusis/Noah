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

  end

end
