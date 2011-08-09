class Noah::App

  put '/:primitive/*/link' do |primitive, name|
    required_params = ["link_name"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (link(primitive, name, data["link_name"])) : (raise "Missing Parameters")
  end

  delete '/:primitive/*/link' do |primitive, name|
    required_params = ["link_name"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (unlink(primitive, name, data["link_name"])) : (raise "Missing Parameters")
  end

  get '/:link_name/:model_name/:item/?' do |path, model, item|
    link_name = find_named_link(path)
    (halt 404) if link_name.to_hash.has_key?(model.to_sym) == false
    (halt 404) if link_name.to_hash[model.to_sym].has_key?(item) == false
    link_name.to_hash[model.to_sym][item].merge({:name => item}).to_json
  end

  get '/:link_name/:model_name/?' do |path, model|
    link_name = find_named_link(path)
    (halt 404) if link_name.to_hash.has_key?(model.to_sym) == false
    link_name.to_hash[model.to_sym].to_json
  end

  get '/:link_name/?' do |path|
    link_name = find_named_link(path)
    link_name.to_json
  end

end
