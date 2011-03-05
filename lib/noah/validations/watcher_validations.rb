module Noah
  module WatcherValidations

      def assert_not_subset(error = [:pattern, :already_provided])
        self.instance_of?(Noah::Watcher) ? (assert endpoint_covered?, error) : (assert false, "Validation not applicable")
      end

      def assert_not_superset(error = [:pattern, :replaces_existing])
        self.instance_of?(Noah::Watcher) ? (assert endpoint_overrides?, error) : (assert false, "Validation not applicable")
      end

      private
      def endpoint_covered?
        watches = Watcher.all.find(:endpoint => self.endpoint).sort
        watches.each do |w|
          if (w.pattern.size < self.pattern.size) && self.pattern.match(/^#{w.pattern}/)
            return false
          end
        end
      rescue ArgumentError
        return false
      end

      def endpoint_overrides?
        watches = Watcher.all.find(:endpoint => self.endpoint).sort
        watches.each do |w|
          if (w.pattern.size > self.pattern.size) && w.pattern.match(/^#{self.pattern}/)
            return false
          end
        end
      rescue ArgumentError
        return false
      end

  end
end
