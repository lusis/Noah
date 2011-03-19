module Noah
  class Ephemeral < Model
    include EphemeralValidations

    attribute :path
    attribute :data
    attribute :lifetime

    index :path

    def validate
      super
      assert_present :path
      assert_unique :path
      assert_not_reserved
    end

    def name
      @name = path
    end

    def to_hash
      h = {:path => path, :data => data, :created_at => created_at, :updated_at => updated_at}
      super.merge(h)
    end

    class << self
    def find_or_create(opts = {})
      begin
        path, data = opts[:path], opts[:data]
        find(:path => path).first.nil? ? (eph = new(:path => path)) : (eph = find(:path => path).first)
        eph.data = data
        if eph.valid?
          eph.save
        end
        eph
      rescue Exception => e
        e.message
      end
    end
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
