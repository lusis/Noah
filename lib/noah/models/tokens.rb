module Noah
  class Token < Model
    include Taggable
    include Linkable
    attribute :name
    attribute :token
    attribute :lifetime

    index :name
    index :token
    index :lifetime

    before :save, :generate_api_token

    def validate
      super
      assert_present :name
      assert_unique :name
      assert_unique :token
    end

    def to_hash
      h = {:token => token, :lifetime => lifetime, :created_at => created_at, :updated_at => updated_at}
      super.merge(h)
    end

    protected
    def generate_api_token
      # Wicked hot logic to generate an API token
      random_string = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
      self.token.nil? ? self.token = OpenSSL::Digest::SHA256.hexdigest(random_string << self.name << Time.now.to_s) : self.token
    end

    def save_hook
      # called after any create,update,delete
      # logic needed to expire any orphaned ephemerals
    end

  end

end
