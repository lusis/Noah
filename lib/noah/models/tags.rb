module Noah
  class Tag < Model
    counter :total

    def name
      @name = id
    end

    def self.[](id)
      super(encode(id)) || create(:id => encode(id))
    end

    def tagged
      
    end
    def all
      
    end
  end

end
