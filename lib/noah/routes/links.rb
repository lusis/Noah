class Noah::App

  get '/:link_name/:model_name/?' do |path, model|
    link_name = Noah::Link.find(:path => "/"+path).first
    if link_name.nil?
      # So maybe they forgot to add the path with a leading slash?
      link_name = Noah::Link.find(:path => path).first
      (halt 404) if link_name.nil?
    end
    (halt 404) if link_name.to_hash.has_key?(model.to_sym) == false
    link_name.to_hash[model.to_sym].to_json
  end

  get '/:link_name/?' do |link|
    link_name = Noah::Link.find(:path => "/"+link).first
    if link_name.nil?
      # So maybe they forgot to add the path with a leading slash?
      link_name = Noah::Link.find(:path => link).first
      (halt 404) if link_name.nil?
    end
    link_name.to_json
  end

end
