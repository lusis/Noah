require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Noah App Basics", :reset_redis => true do

  it "should show the index page as html" do
    header "Accept", "text/html"
    get '/'
    last_response.should be_ok
    last_response.body.include?("Noah Start Page").should  == true
  end

  it "should show the index page as json" do
    header "Accept", "application/json"
    get '/'
    last_response.should return_json
    response = JSON.parse(last_response.body)
    response.has_key?("redis_version").should == true
    response.has_key?("noah_version").should == true
    response.has_key?("resources").should == true
  end

  it "should test the 404 message" do
    get '/foo'
    last_response.status.should == 404
    last_response.should return_json
    response = JSON.parse(last_response.body)
    response["result"].should == "failure"
    response["error_message"].should == "Resource not found"
  end  

end
