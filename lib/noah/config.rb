module Noah
  module Config

    @conf ||= "config/config.yml"

    def self.config_file
      @conf
    end

    def self.config_file=(config)
      @conf = config
    end

    def self.configured?
      @conf.nil? ? false : true
    end

    def self.configure!
      puts "Configuring Noah from: #{@conf}"
    end  
  end
end

