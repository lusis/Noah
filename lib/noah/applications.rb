require File.join(File.dirname(__FILE__), 'configurations')
module Noah
  class Application < Model

    collection :configurations, Configuration

    def to_hash
      arr = []
      configurations.sort.each {|c| arr << c.to_hash}
      super.merge(:name => name, :created_at => created_at, :updated_at => updated_at, :configurations => arr)
    end

    class << self
    def find_or_create(opts = {})
      begin
        find(opts).first.nil? ? (app = create(opts)) : (app = find(opts).first)
        if app.valid?
          app.save
        end
        app
      rescue Exception => e
        e.message
      end
    end
    end

  end

  class Applications
    def self.all(options = {})
      options.empty? ? Application.all.sort : Application.find(options).sort
    end
  end
end
