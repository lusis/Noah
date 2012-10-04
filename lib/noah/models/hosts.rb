require File.join(File.dirname(__FILE__), 'services')
module Noah
  class Host < Model
    # Host model
    # @return {Host} a {Host} object
    include Taggable
    include Linkable
    attribute :name
    attribute :status
    collection :services, Service

    index :name
    index :status
    index :services

    def validate
      super
      assert_present :name
      assert_present :status
      assert_unique :name
      assert_member :status, ["up","down","pending"]
    end

    # @return [Hash] A hash representation of a {Host}
    def to_hash
      services_hash = Hash.new
      services.sort.each do |svc|
        services_hash["#{svc.name}"] = svc.status
      end
      h = {:name => name, :status => status, :created_at => created_at, :updated_at => updated_at, :services => services_hash}
      super.merge(h)
    end

    class << self
      def find_or_create(opts = {})
        h = find(:name => opts[:name]).first
        #h = find(opts.reject{|key,value| key == :status}).first
        h.nil? ? host=new(opts) : host=h
        host.status = opts[:status]
        if host.valid?
          host.save
        end
        host
      end
    end

  end

  class Hosts
    # @param [Hash] optional filters for results
    # @return [Array] Array of {Host} objects
    def self.all(options = {})
      host_hash = Hash.new
      options.empty? ? hosts=Noah::Host.all.sort : hosts=Noah::Host.find(options).sort
      hosts.each {|x| host_hash["#{x.name}"] = x.to_hash.reject {|k,v| k == :name } }
      host_hash
    end
  end
end
