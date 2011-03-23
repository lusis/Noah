module Noah
  class LinkMember

    class <<self
      def create(path)
        path_to_instance(path)
      end

      protected
      def path_to_instance(path)
        p = path.split('/')
        model, name = p[1], p[2]
        x = instance_eval(Noah::PATH_MAPPING[model])
        x.find(:name => name).first
      end
    end
  end
end
