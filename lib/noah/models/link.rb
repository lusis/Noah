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
      # TODO Holy shit, is this messy or what?
      # Prepopulate instance variables of each object type instead?
      %w[applications configurations hosts services ephemerals].each {|x| instance_variable_set("@#{x}", Hash.new)}
      if nodes.size > 0
        nodes.each do |node|
          n = node_to_class(node)
          cls = class_to_lower(n.class.to_s)
          hsh = instance_variable_get("@#{cls}s")
          hsh["#{n.name}"] = Hash.new unless hsh.has_key?(n.name)
          # all of this bs is because services are unique per [servicename, hostname]
          # so if I add multiple services just by name to the hash, I'll wipe the previous one
          # a better option would be for services to be named slug style 
          if cls == "service"
            hsh[n.name].merge!({n.to_hash[:host] => n.to_hash})
          else
            hsh[n.name].merge!(n.to_hash)
          end
        end
      end
      h = {:name => name, :hosts => @hosts, :services => @services, :applications => @applications, :configurations => @configurations, :ephemerals => @ephemerals, :created_at => created_at, :updated_at => updated_at}
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
