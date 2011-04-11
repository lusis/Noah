module Noah
  class Tag < Model
    attribute :name
    attribute :members
    index :members
    index :name

    def validate
      super
      assert_present :name
      assert_unique :name
    end

    def members=(member)
      self.key[:members].sadd(member.key)
      member.tag! self.name unless member.tags.member?(self)
    end

    def members
      hsh = Hash.new
      self.key[:members].smembers.each do |member|
        n = node_to_class(member)
        cls = class_to_lower(n.class.to_s)
        hash_key = "#{cls}s".to_sym
        hsh[hash_key] = Array.new unless hsh.has_key?(hash_key)
        hsh[hash_key] << n.name
      end
      hsh
    end

    def self.tagged(tag)
      t = find(:name => tag).first
      t.members
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

    private
    def node_to_class(node)
      node.match(/^Noah::(.*):(\d+)$/)
      Noah.const_get($1).send(:[], $2)
    end
  end

end
