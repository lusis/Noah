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
          n.links << self
        end
      else
        self.key[:nodes].sadd(node.key)
        node.links << self
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
          rejected_vals = [:created_at, :updated_at, :links, :name]
          n = node_to_class(node)
          cls = class_to_lower(n.class.to_s)
          hsh = instance_variable_get("@#{cls}s")
          # all of this bs is because services are unique per [servicename, hostname]
          # so if I add multiple services just by name to the hash, I'll wipe the previous one
          # a better option would be for services to be named slug style 
          hsh["#{n.name}"] = Hash.new unless hsh.has_key?(n.name)
          case cls
          when "service"
            sh = Noah::Host[n.host_id].name
            hsh["#{n.name}"]["#{sh}"] = Hash.new unless hsh["#{n.name}"].has_key?("#{sh}")
            hsh["#{n.name}"]["#{sh}"].merge!({:id => n.id, :status => n.status, :tags => n.to_hash[:tags]})
          when "host"
            hsh["#{n.name}"].merge!({:id => n.id, :status => n.status, :tags => n.to_hash[:tags], :services => n.to_hash[:services]})
          else
            hsh["#{n.name}"].merge!(n.to_hash.reject{|key, value| rejected_vals.member?(key)})
          end
        end
      end
      h = {:name => name, :hosts => @hosts, :services => @services, :applications => @applications, :configurations => @configurations, :ephemerals => @ephemerals, :created_at => created_at, :updated_at => updated_at}
      super.merge(h)
    end

    def name
      @name = path
    end

    class <<self
    def find_or_create(opts={})
      begin
        find(opts).first.nil? ? obj=create(opts) : obj=find(opts).first
        obj
      rescue Exception => e
        e.message
      end
    end
    end

    private
    def node_to_class(node)
      node.match(/^Noah::(.*):(.*)$/)
      Noah.const_get($1).send(:[], $2)
    end
  end
end
