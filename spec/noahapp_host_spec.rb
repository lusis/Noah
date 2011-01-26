require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "NoahApp Host API", :reset_redis => false, :populate_sample_data => true do

  it "GET /h" do
    get '/h'
    last_response.should be_ok
    last_response.headers["Content-Type"].should == "application/json"
  end

  it "GET /h/localhost" do
    get '/h/localhost'
    last_response.should be_ok
    last_response.headers["Content-Type"].should == "application/json"
    host = JSON.parse(last_response.body)
    services = host["services"]

    host["name"].should == "localhost"
    host["status"].should == "up"
    services.size.should == 2
    services.first["name"].should == "redis"
    services.first["status"].should == "up"
    services.first["host"].should == "localhost"
    services.last["name"].should == "noah"
    services.last["status"].should == "up"
    services.last["host"].should == "localhost"
  end  

  it "GET /h/localhost/noah" do
    get '/h/localhost/noah'
    last_response.should be_ok
    last_response.headers["Content-Type"].should == "application/json"
    service = JSON.parse(last_response.body)
    service["name"].should == "noah"
    service["status"].should == "up"
    service["host"].should == "localhost"
  end  
end
