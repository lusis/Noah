class Noah::App

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
