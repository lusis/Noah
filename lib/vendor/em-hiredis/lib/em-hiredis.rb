require 'eventmachine'

module EM
  module Hiredis
    class << self
      attr_writer :logger

      def logger
        @logger ||= begin
          require 'logger'
          log = Logger.new(STDOUT)
          log.level = Logger::WARN
          log
        end
      end
    end
  end
end

require 'em-hiredis/event_emitter'
require 'em-hiredis/connection'
require 'em-hiredis/client'
