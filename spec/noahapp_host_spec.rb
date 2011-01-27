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

  it "PUT /h/:hostname - new host" do
    host_data = {:name => "host99.domain.com", :status => "down"}.to_json
    put '/h/host99.domain.com', host_data, "CONTENT_TYPE" => "application/json"
    last_response.should be_ok
    last_response.headers["Content-Type"].should == "application/json"
    response = JSON.parse(last_response.body)
    response["result"].should == "success"
    response["id"].nil?.should == false
    response["name"].should == "host99.domain.com"
    response["status"].should == "down"
    response["new_record"].should == true
  end

  it "PUT /h/:hostname - existing host" do
    sleep 3
    host_data = {:name => "localhost", :status => "pending"}.to_json
    put '/h/host99.domain.com', host_data, "CONTENT_TYPE" => "application/json"
    last_response.should be_ok
    last_response.headers["Content-Type"].should == "application/json"
    response = JSON.parse(last_response.body)
    response["new_record"].should == false
  end

  it "PUT /h/:hostname - missing name parameter" do
    host_data = {:status => "pending"}.to_json
    put '/h/host100.domain.com', host_data, "CONTENT_TYPE" => "application/json"
    last_response.should_not be_ok
    last_response.headers["Content-Type"].should == "application/json"
    response = JSON.parse(last_response.body)
    response["result"].should == "failure"
    response["error_message"].should == "Missing Parameters"
  end

  it "PUT /h/:hostname - missing status parameter" do
    host_data = {:name => "host100.domain.com"}.to_json
    put '/h/host100.domain.com', host_data, "CONTENT_TYPE" => "application/json"
    last_response.should_not be_ok
    last_response.headers["Content-Type"].should == "application/json"
    response = JSON.parse(last_response.body)
    response["result"].should == "failure"
    response["error_message"].should == "Missing Parameters"
  end 

  it "PUT /h/:hostname - invalid status parameter" do
    host_data = {:name => "host100.domain.com", :status => "fscked"}.to_json
    put '/h/host100.domain.com', host_data, "CONTENT_TYPE" => "application/json"
    last_response.should_not be_ok
    last_response.headers["Content-Type"].should == "application/json"
    response = JSON.parse(last_response.body)
    response["result"].should == "failure"
    response["error_message"].should == "[[:status, :not_member]]"
  end

  it "DELETE /h/:hostname - existing host" do
    h = Host.find(:name => "localhost").first
    svc_size = h.services.size
    host_data = {:name => "localhost"}
    delete '/h/localhost', host_data, "CONTENT_TYPE" => "application/json"
    last_response.should be_ok
    last_response.headers["Content-Type"].should == "application/json"
    response = JSON.parse(last_response.body)
    response["result"].should == "success"
    response["id"].should == h.id
    response["name"].should == "localhost"
    response["service_count"].should == svc_size.to_s
  end

  it "DELETE /h/:hostname - invalid host" do
    host_data = {:name => "invalid_host.asdf.com"}
    delete '/h/invalid_host.asdf.com', host_data, "CONTENT_TYPE" => "application/json"
    last_response.should_not be_ok
    last_response.status.should == 404
    response = JSON.parse(last_response.body)
    response["result"].should == "failure"
    response["error_message"].should == "Resource not found"
  end
end
