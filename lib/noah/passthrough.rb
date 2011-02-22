module Noah
  module Passthrough
    def passthrough(*methods)
      methods.each do |method|
        raise ArgumentError if ! method.is_a?(Symbol)
        meth = method.to_s
        self.class_eval("def #{meth}(*args); self.class.#{meth}(*args); end")
      end
    end
  end
end
