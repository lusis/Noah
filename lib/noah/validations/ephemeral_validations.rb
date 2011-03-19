module Noah
  module EphemeralValidations

      def assert_not_reserved(error = [:path, :reserved_path])
        # This is to work around how Ohm evaluates validations
        # Allows assert_present :path to override
        return if self.path.nil?
        # This is the real test
        self.instance_of?(Noah::Ephemeral) ? (assert valid_path?, error) : (assert false, "Validation not applicable")
      end

      private
      def valid_path?
        PROTECTED_PATHS.member?(self.path.split("/")[1]) ? (return false) : (return true)
      rescue ArgumentError
        return false
      end

  end
end
