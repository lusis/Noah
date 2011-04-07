class Noah::App
  get '/*/?' do
    path = params[:splat][0]
    link_name = Noah::Link.find(:path => "/"+path).first
    (halt 404) if link_name.nil?
    link_name.to_json
  end
end
