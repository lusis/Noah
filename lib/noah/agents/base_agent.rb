module Noah::Agents
  class Base

    PREFIX = "base"
    NAME = "base-agent"
    DEFAULT_CONCURRENCY = 1

    def self.inherited(base)
      Noah::Watchers.register_agent(base)
      base.send :include, EM::Deferrable
    end

    def notify(event, message, watch_list)
      logger.info("#{self.class} worker initiated")
      worklist = []
      watch_list.select{|w| worklist << w[:endpoint] if (w[:endpoint] =~ /^#{self.class::PREFIX}/ && event =~ /^#{w[:pattern]}/) }
      if worklist.size >= 1
        logger.info("Dispatching message to #{worklist.size} #{self.class.to_s} endpoints")
        EM::Iterator.new(worklist, self.class::DEFAULT_CONCURRENCY).each do |ep, iter|
          work!(ep, message)
          iter.next
        end
        logger.info("Dispatched message to #{worklist.size} #{self.class.to_s} endpoints")
      else
        logger.info("No work to do")
      end
    rescue Exception => e
      logger.fatal("Exectution of notify failed with #{e.message}")
    end

    def logger
      Noah::Log.logger.progname = self.class.to_s
      Noah::Log.logger
    end

  end

end
