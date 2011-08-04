class Noah::App

  put '/:primitive/*/tag' do |primitive, name|
    required_params = ["tags"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (tag(primitive, name, data["tags"])) : (raise "Missing Parameters")
  end

  delete '/:primitive/*/tag' do |primitive, name|
    required_params = ["tags"]
    data = JSON.parse(request.body.read)
    (data.keys.sort == required_params.sort) ? (untag(primitive, name, data["tags"])) : (raise "Missing Parameters")
  end

  get '/tags/:tagname/?' do |tagname|
    tags = Noah::Tags.all(:name => tagname).to_hash
    (halt 404) if tags.size == 0
    tags.to_json
  end

  get '/tags/?' do
    tags = Noah::Tags.all.to_hash
    (halt 404) if tags.size == 0
    tags.to_json
  end

end
