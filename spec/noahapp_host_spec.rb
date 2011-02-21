require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Host API", :reset_redis => false, :populate_sample_data => true do
  describe "calling" do

    describe "GET" do
      it "all hosts should work" do
        get '/h'
        last_response.should be_ok
        last_response.should return_json
      end

      it "existing host should work" do
        get '/h/localhost'
        last_response.should be_ok
        response = last_response.should return_json

        services = response["services"]

        response["name"].should == "localhost"
        response["status"].should == "up"
        services.size.should == 2
        services.first["name"].should == "redis"
        services.first["status"].should == "up"
        services.first["host"].should == "localhost"
        services.last["name"].should == "noah"
        services.last["status"].should == "up"
        services.last["host"].should == "localhost"
      end  

      it "named service for host should work" do
        get '/h/localhost/noah'
        last_response.should be_ok
        response = last_response.should return_json

        response["name"].should == "noah"
        response["status"].should == "up"
        response["host"].should == "localhost"
      end
    end

    describe "PUT" do
      it "new host should work" do
        host_data = {:name => "host99.domain.com", :status => "down"}.to_json
        put '/h/host99.domain.com', host_data, "CONTENT_TYPE" => "application/json"
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
        host_data = {:name => "host99.domain.com", :status => "pending"}.to_json
        put '/h/host99.domain.com', host_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json

        response["new_record"].should == false
      end

      it "host missing name parameter should not work" do
        host_data = {:status => "pending"}.to_json
        put '/h/host100.domain.com', host_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end

      it "host missing status parameter should not work" do
        host_data = {:name => "host100.domain.com"}.to_json
        put '/h/host100.domain.com', host_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end 

      it "host with invalid status parameter should not work" do
        host_data = {:name => "host100.domain.com", :status => "fscked"}.to_json
        put '/h/host100.domain.com', host_data, "CONTENT_TYPE" => "application/json"
        last_response.should_not be_ok
        response = last_response.should return_json

        response["result"].should == "failure"
        response["error_message"].should == "[[:status, :not_member]]"
      end
    end

    describe "DELETE" do
      before(:all) do
        @h = Noah::Host.create(:name => 'h', :status => 'up')
        sparms = {:name => 's', :status => "up"}
        @h.services << Noah::Service.create(sparms.merge({:host => @h}))
        @h.save
        @s = @h.services.first
      end  
      it "existing host should work" do
        svc_size = @h.services.size
        delete "/h/#{@h.name}"
        last_response.should be_ok
        response = last_response.should return_json

        response["result"].should == "success"
        response["id"].should == @h.id
        response["name"].should == @h.name
        response["service_count"].should == svc_size.to_s
      end

      it "invalid host should not work" do
        delete "/h/#{@h.name}"
        last_response.should be_missing
      end
    end

  end
end
