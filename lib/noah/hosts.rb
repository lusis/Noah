require File.join(File.dirname(__FILE__), 'services')
module Noah
  class Host < Model
    # Host model
    # @return {Host} a {Host} object

    attribute :status
    collection :services, Service

    index :status

    def validate
      super
      assert_present :status
      assert_unique :name
      assert_member :status, ["up","down","pending"]
    end

    # @return [Hash] A hash representation of a {Host}
    def to_hash
      arr = []
      services.sort.each {|s| arr << s.to_hash}
      h = {:name => name, :status => status, :created_at => created_at, :updated_at => updated_at, :services => arr}
      super.merge(h)
    end

    class << self
    def find_or_create(opts = {})
      begin
        # exclude requested status from lookup
        h = find(opts.reject{|key,value| key == :status}).first
        host = h.nil? ? create(opts) : h
        host.status = opts[:status]
        if host.valid?
          host.save
        end
        host
      rescue Exception => e
        e.message
      end
    end
    end

  end

  class Hosts
    # @param [Hash] optional filters for results
    # @return [Array] Array of {Host} objects
    def self.all(options = {})
      options.empty? ? Noah::Host.all.sort : Noah::Host.find(options).sort
    end
  end
end
