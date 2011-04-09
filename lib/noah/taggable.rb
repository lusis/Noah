module Noah::Taggable
  def self.included(model)
    model.send :set, :tags, ::Noah::Tag
    model.send :index, :tags
  end

  def tag!(tag_name)
    tags << ::Noah::Tag.find_or_create(:name => tag_name)
  end

  def untag!(tag_name)
  end

  def to_hash
    tag_arr = []
    self.tags.sort.each {|t| tag_arr << t.name} if self.tags.size != 0
    super.merge(:tags => tag_arr)
  end
end
