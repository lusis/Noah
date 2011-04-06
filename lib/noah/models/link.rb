module Noah
  class Link < Model
    attribute :path
    attribute :nodes

    index :path
    index :nodes

    def nodes
      arr = []
      self.key[:nodes].smembers.each do |node|
        arr << node
      end
      arr
    end

    def nodes=(node)
      case node.class.to_s
      when "Array"
        node.each do |n|
          self.key[:nodes].sadd(n.key)
        end
      else
        self.key[:nodes].sadd(node.key)
      end
    end

    def validate
      super
      assert_present :path
    end

    def to_hash
      n = Array.new
      nodes.each {|node| n << node_to_class(node).to_hash} if nodes.size > 0
      h = {:name => name, :nodes => n, :created_at => created_at, :updated_at => updated_at}
      super.merge(h)
    end

    def name
      @name = path
    end
    private
    def node_to_class(node)
      node.match(/^Noah::(.*):(\d+)$/)
      Noah.const_get($1).send(:[], $2)
    end
  end
end
