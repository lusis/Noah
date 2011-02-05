module Noah

  class Config
#    attr_accessor :config_file
#    attr_accessor :settings
#    attr_accessor :log_file
#    attr_accessor :log_level
#    attr_accessor :mode
#    attr_accessor :database_url
#
#    @conf ||= "config/config.yml"
#    @logfile ||= "logs/noah.log"
#    @log_level ||= "debug"
#    @mode ||= "development"
#    @database_url ||= "redis://localhost:6379/0"
#
#    def self.configured?
#      @config_file.nil? ? false : true
#    end
#
#    def self.configure!
#      puts "Configuring Noah from: #{@config_file}"
#      parse
#    end  
#
#    private
#    def parse(conf_file = @congig_file)
#      begin
#        @settings = YAML.load_file(conf_file)
#      rescue Exception => e
#        puts "Unable to parse configuration: #{conf_file}"
#        puts e.message
#      end
#    end  
#  end

    def initialize(data = {})
      @data = {}
      update!(data)
    end

    def update!(data)
      data.each do |k,v|
        self[k] = v
      end
    end

    def []=(k,v)
      v.class == Hash ? @data[k.to_sym] = Config.new(v) : @data[k.to_sym] = v
    end

    def configured?
      @data.size == 0 ? false : true
    end

    def method_missing(sym, *args)
      if sym.to_s =~ /(.+)=$/
        self[$1] = args.first
      else
        self[sym]
      end
    end
  end

end
