require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Host API", :reset_redis => false, :populate_sample_data => true do
  describe "calling" do

    describe "GET" do
      it "all hosts should work" do
        get '/hosts'
        last_response.should be_ok
        last_response.should return_json
      end

      it "existing host should work" do
        get '/hosts/localhost'
        last_response.should be_ok
        response = last_response.should return_json

        services = response["services"]

        response["name"].should == "localhost"
        response["status"].should == "up"
        services.size.should == 2
        services.has_key?("redis").should == true
        services.has_key?("noah").should == true
        services["redis"].should == "up"
        services["noah"].should == "up"
      end  

      it "named service for host should work" do
        get '/hosts/localhost/services/noah'
        last_response.should be_ok
        response = last_response.should return_json

        response["name"].should == "noah"
        response["status"].should == "up"
        response["host"].should == "localhost"
      end
    end

    describe "PUT" do
      it "new host should work" do
        host_data = {:status => "down"}.to_json
        put '/hosts/host99.domain.com', host_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json

        response["result"].should == "success"
        response["id"].nil?.should == false
        response["name"].should == "host99.domain.com"
        response["status"].should == "down"
        response["new_record"].should == true
      end

      it "existing host should work" do
        sleep 3
        host_data = {:status => "pending"}.to_json
        put '/hosts/host99.domain.com', host_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json

        response["new_record"].should == false
      end

      it "host missing status parameter should not work" do
        put '/hosts/host100.domain.com', "{}", "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end 

      it "host with invalid status parameter should not work" do
        host_data = {:status => "fscked"}.to_json
        put '/hosts/host100.domain.com', host_data, "CONTENT_TYPE" => "application/json"
        last_response.should_not be_ok
        response = last_response.should return_json

        response["result"].should == "failure"
        response["error_message"].should == "Status must be up, down or pending"
      end
    end

    describe "DELETE" do
      before(:each) do
        Ohm.redis.flushdb
        @h = Noah::Host.create(:name => 'h', :status => 'up')
        sparms = {:name => 's', :status => "up"}
        @h.services << Noah::Service.create(sparms.merge({:host => @h}))
        @h.save
        @s = @h.services.first
      end  
      it "existing host should work" do
        svc_size = @h.services.size
        delete "/hosts/#{@h.name}"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["id"].should == @h.id
        response["name"].should == @h.name
        response["service_count"].should == svc_size.to_s
      end

      it "valid service from valid host should work" do
        delete "/hosts/#{@h.name}/services/#{@s.name}"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "delete"
        response["id"].should == @s.id
        response["host"].should == @h.name
        response["service"].should == @s.name
      end

      it "invalid host should not work" do
        delete "/hosts/not_a_valid_hsot"
        last_response.should be_missing
      end
    end

  end
end
