module Noah
  class Link < Model
    attribute :path
    attribute :source
    
    index :path
    index :source

    def validate
      super
      assert_present :path
      assert_present :source
      assert_unique [:path, :source]
    end
    # Nothing to see yet.
    # This will be for creating "overlays" or "link" relationships
    # between arbitrary objects or modeling your data the way you want.
    #
    # Example:
    # path = "/myservers"
    # path.nodes = ["/applications/myapp","/some/ephemeral/path", "sometag"]
    #
    # would result in a structure like:
    # path/
    #     applications/
    #                  myapp
    #     some/ephemeral/path/
    #                        child1
    #                        child2
    #                        child3
    #     sometag/
    #            tagged_item1
    #            tagged_item2
    #            tagged_item4
    #            tagged_item5
    #
    # The idea is to create a blended view across opinionated, tagged and
    # ephemeral nodes.
    #
    # Almost a "choose your own model" thing.

    def name
      @name = path
    end

  end
end
