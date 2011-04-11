module Noah::Taggable
  def self.included(model)
    model.send :set, :tags, ::Noah::Tag
    model.send :index, :tags
  end

  def tag!(tag_name)
    case tag_name.class.to_s
    when "Array"
      tag_name.each do |t|
        my_tag = ::Noah::Tag.find_or_create(:name => t)
        tags << my_tag
        my_tag.members = self
      end
    else
      my_tag = ::Noah::Tag.find_or_create(:name => tag_name)
      tags << my_tag
      my_tag.members = self
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
