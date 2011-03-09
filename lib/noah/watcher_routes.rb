class Noah::App

  get '/w/?' do
    w = Noah::Watcher.all.sort_by(:pattern)
    if w.size == 0
      halt 404
    else  
      w.to_json
    end  
  end

end
