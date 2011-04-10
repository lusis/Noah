module Noah::Linkable
  def self.included(model)
    model.send :set, :links, ::Noah::Link
    model.send :index, :links
  end

  def link!(link_name)
    link = Noah::Link.find_or_create(:path => link_name)
    link.nodes = self
  end

  def unlink!(link_name)
  end

  def to_hash
    link_arr = Array.new
    self.links.sort.each {|l| link_arr << l.path} if self.links.size != 0
    super.merge(:links => link_arr)
  end
end
