module Noah::Taggable
  def self.included(model)
    model.send :set, :tags, ::Noah::Tag
    model.send :index, :tags
  end

  def tag!(tag_name)
    case tag_name.class.to_s
    when "Array"
      tag_name.each do |t|
        tags << ::Noah::Tag.find_or_create(:name => t)
      end
    else
      tags << Noah::Tag.find_or_create(:name => tag_name)
    end
  end

  def untag!(tag_name)
  end

  def to_hash
    tag_arr = Array.new
    self.tags.sort.each {|t| tag_arr << t.name} if self.tags.size != 0
    super.merge(:tags => tag_arr)
  end
end
