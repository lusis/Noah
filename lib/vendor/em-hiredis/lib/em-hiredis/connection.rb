require 'hiredis/reader'

module EM::Hiredis
  class Connection < EM::Connection
    include EM::Hiredis::EventEmitter

    def initialize(host, port)
      super
      @host, @port = host, port
    end

    def connection_completed
      EM::Hiredis.logger.info("Connected to Redis")
      @reader = ::Hiredis::Reader.new
      emit(:connected)
    end

    def receive_data(data)
      @reader.feed(data)
      until (reply = @reader.gets) == false
        emit(:message, reply)
      end
    end

    def unbind
      EM::Hiredis.logger.info("Disconnected from Redis")
      emit(:closed)
    end

    def send_command(sym, *args)
      send_data(command(sym, *args))
    end

    protected

    COMMAND_DELIMITER = "\r\n"

    def command(*args)
      command = []
      command << "*#{args.size}"

      args.each do |arg|
        arg = arg.to_s
        command << "$#{string_size arg}"
        command << arg
      end

      command.join(COMMAND_DELIMITER) + COMMAND_DELIMITER
    end

    if "".respond_to?(:bytesize)
      def string_size(string)
        string.to_s.bytesize
      end
    else
      def string_size(string)
        string.to_s.size
      end
    end
  end
end
