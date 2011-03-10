require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Service API", :reset_redis => false, :populate_sample_data => true do
  before(:all) do
    @sample_host = {:name => 'rspec_sample_host', :status => 'up'}
    @sample_service = {:name => 'rspec_sample_service', :status => 'up'}
    @h = Noah::Host.create(:name => 'rspec_sample_host', :status => 'up')
    @h.services << Noah::Service.create({:host => @h}.merge(@sample_service))
    @h.save
    @s = Noah::Service.find(@sample_service).first
  end  
  describe "calling" do
    
    describe "GET" do
      it "all services should work" do
        get '/s'
        last_response.should be_ok
        response = last_response.should return_json
        response.is_a?(Array).should == true
      end
      it "all named services should work" do
        get "/s/#{@sample_service[:name]}"
        last_response.should be_ok
        response = last_response.should return_json
        response.is_a?(Array).should == true
        s = response.first
        s["id"].should == @s.id
        s["name"].should == @s.name
        s["status"].should == @s.status
        s["host"].should == @h.name
      end
      it "named service for host should work" do
        get "/s/#{@sample_service[:name]}/#{@sample_host[:name]}"
        last_response.should be_ok
        response = last_response.should return_json
        response["id"].should == @s.id
        response["name"].should == @s.name
        response["status"].should == @s.status
        response["host"].should == @h.name
      end
      it "missing service for host should not work" do
        get '/s/foobar/baz'
        last_response.should be_missing
      end
    end

    describe "PUT" do
      before(:all) do
        @payload = {:name => 'another_rspec_service', :status => 'up', :host => @h.name}
      end  
      it "new service should work" do
        put "/s/#{@payload[:name]}/", @payload.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "create"
        response["id"].nil?.should == false
        response["name"].should == @payload[:name]
        response["host"].should == @payload[:host]
        Noah::Service.find(:name => @payload[:name]).size.should == 1
        Noah::Service.find(:name => @payload[:name]).first.is_new?.should == true
      end
      it "new service without host should not work" do
        put "/s/foobar", {:name => "foobar", :status => "up"}.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end  
      it "new service with invalid status should not work" do
        put "/s/foobar", {:name => "foobar", :status => "fsck", :host => @h.name}.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should_not be_ok
        response = last_response.should return_json
        response["error_message"].should == "Status must be up, down or pending"
      end  
      it "new service with missing name should not work" do
        put "/s/foobar", {:status => "fsck", :host => @h.name}.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end
      it "new service with missing status should not work" do
        put "/s/foobar", {:name => "foobar", :host => @h.name}.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end  
      it "existing service should work" do
        sleep 3
        put "/s/#{@payload[:name]}", {:name => @payload[:name], :status => "down", :host => @payload[:host]}.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "update"
        response["id"].nil?.should == false
        response["name"].should == @payload[:name]
        response["host"].should == @payload[:host]
        Noah::Service.find(:name => @payload[:name]).size.should == 1
        Noah::Service.find(:name => @payload[:name]).first.is_new?.should == false
      end
    end

    describe "DELETE" do
      before(:all) do
        @h = Noah::Host.create(:name => "h1", :status => "up")
        @h.services << Noah::Service.create(:name => "s1", :status => "up", :host => @h)
        @h.save
        @s = @h.services.first
      end  
      it "existing host should work" do
        delete "/s/#{@s.name}/#{@h.name}"
        last_response.should be_ok
        response = last_response.should return_json
        
        response["result"].should == "success"
        response["action"].should == "delete"
        response["id"].should == @s.id
        response["host"].should == @h.name
        response["service"].should == @s.name
      end  
      it "invalid host should not work" do
        delete "/s/#{@s.name}/#{@h.name}"
        last_response.should be_missing
      end
    end
  
  end
end  
