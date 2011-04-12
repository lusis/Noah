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
        hsh[hash_key] << n
      end
      hsh
    end

    def to_hash
      h = {:name => name, :created_at => created_at, :updated_at => updated_at}
      h.merge!(members_to_hash)
      super.merge(h)
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
      node.match(/^Noah::(.*):(\d+)$/)
      Noah.const_get($1).send(:[], $2)
    end

    def members_to_hash
      new_hash = Hash.new
      members.keys.each {|k| new_hash[k] = Hash.new}
      members.each do |category, member_array|
        rejected_vals = [:created_at, :updated_at, :tags, :name, :host]
        h = new_hash[category]
        member_array.each {|mem| h["#{mem.name}"] = Hash.new unless h.has_key?(mem.name)}
        case category
        when :services
          member_array.each do |s|
            sh = Noah::Host[s.host_id].name
            h["#{s.name}"]["#{sh}"] = Hash.new unless h["#{s.name}"].has_key?(sh)
            h["#{s.name}"]["#{sh}"].merge!(s.to_hash.reject{|k,v| rejected_vals.member?(k)})
          end
        else
          member_array.each do |m|
            h["#{m.name}"].merge!(m.to_hash.reject{|k,v| rejected_vals.member?(k)})
          end
        end
      end
      new_hash
    end
  end

  class Tags
    def self.all(options = {})
      tag_hash = Hash.new
      options.empty? ? tags=Tag.all.sort : tags=Tag.find(options).sort
      tags.each {|t| tag_hash["#{t.name}"] = t.to_hash.reject {|k,v| k == :name } }
      tag_hash
    end

    class <<self
      def tagged(tag)
        t = Tag.find(:name => tag).first
        t.members
      end
    end
  end

end
