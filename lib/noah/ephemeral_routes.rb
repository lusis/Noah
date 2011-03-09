class Noah::App
  # Stubbing Ephemeral endpoints
  get '/e/*' do
    # Some logic to handle splats for ephemerals
    # Eventually I'll move to root path
  end

  put '/e/*/watch' do
    # Logic for adding watches to ephemerals
  end

  put '/e/*' do
    # Some logic for creating ephemerals
  end

  delete '/e/*' do
    # See previous two entries
  end
end
