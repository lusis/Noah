class Noah::App

  get '/:link_name/:model_name/?' do |path, model|
    link_name = Noah::Link.find(:path => "/"+path).first
    (halt 404) if link_name.nil?
    (halt 404) if link_name.to_hash.has_key?(model.to_sym) == false
    link_name.to_hash[model.to_sym].to_json
  end

  get '/:link_name/?' do |path|
    link_name = Noah::Link.find(:path => "/"+path).first
    (halt 404) if link_name.nil?
    link_name.to_json
  end

end
