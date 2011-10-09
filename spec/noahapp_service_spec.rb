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
        get '/services'
        last_response.should be_ok
        response = last_response.should return_json
        response.is_a?(Hash).should == true
      end
      it "all named services should work" do
        get "/services/#{@sample_service[:name]}"
        last_response.should be_ok
        response = last_response.should return_json
        response.class.to_s.should == "Hash"
        response.has_key?(@s.name.to_s).should == true
        response["#{@s.name}"].class.to_s.should == "Hash"
        response["#{@s.name}"].has_key?(@h.name.to_s).should == true
        response["#{@s.name}"]["#{@h.name}"].class.to_s.should == "Hash"
        response["#{@s.name}"]["#{@h.name}"]["id"].should == @s.id
        response["#{@s.name}"]["#{@h.name}"]["status"].should == @s.status
      end
      it "named service for host should work" do
        get "/services/#{@sample_service[:name]}/#{@sample_host[:name]}"
        last_response.should be_ok
        response = last_response.should return_json
        response["id"].should == @s.id
        response["name"].should == @s.name
        response["status"].should == @s.status
        response["host"].should == @h.name
      end
      it "missing service for host should not work" do
        get '/services/foobar/baz'
        last_response.should be_missing
      end
    end

    describe "PUT" do
      before(:each) do
        Ohm.redis.flushdb
        @host_name = 'rspec_sample_host'
        @service_name = 'rspec_sample_service'
        @payload = {:status => 'up', :host_status => 'up'}
      end
      after(:each) do
        Ohm.redis.flushdb
      end
      it "new service on new host should work" do
        put "/services/#{@service_name}/#{@host_name}", @payload.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "create"
        response["id"].nil?.should == false
        response["name"].should == @service_name
        response["host"]["name"].should == @host_name
        response["host"]["status"].should == 'up'
        response["host"]["action"].should == 'create'
        response["host"]["status"].should == 'up'
        Noah::Service.find(:name => @service_name).size.should == 1
        Noah::Service.find(:name => @service_name).first.is_new?.should == true
        Noah::Host.find(:name => @host_name).size.should == 1
        Noah::Host.find(:name => @host_name).first.is_new?.should == true
      end
      it "new service on existing host should work" do
        hostname = 'non-existant-rspec-host'
        servicename = 'non-existant-rspec-service'
        Noah::Host.create(:name => hostname, :status => 'up')
        sleep(3)
        put "/services/#{servicename}/#{hostname}", @payload.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "create"
        response["id"].nil?.should == false
        response["name"].should == servicename
        response["host"]["name"].should == hostname
        response["host"]["status"].should == 'up'
        response["host"]["action"].should == 'update'
        Noah::Service.find(:name => servicename).size.should == 1
        Noah::Service.find(:name => servicename).first.is_new?.should == true
      end
      it "new service with invalid host status should not work" do
        put "/services/foobar/#{@host_name}", {:host_status => "fsck", :status => "up"}.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should_not be_ok
        response = last_response.should return_json
        response["error_message"].should == "Status must be up, down or pending"
      end  
      it "new service with invalid service status should not work" do
        put "/services/foobar/#{@host_name}", {:host_status => "up", :status => "fsck"}.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should_not be_ok
        response = last_response.should return_json
        response["error_message"].should == "Status must be up, down or pending"
      end  
      it "new service with missing host_status should not work" do
        put "/services/foobar/#{@host_name}", {:status => "up"}.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end
      it "new service with missing status should not work" do
        put "/services/foobar/#{@host_name}", {:host_status => 'up'}.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end  
      it "existing service should work" do
        a = Noah::Host.create(:name => @host_name, :status => 'up')
        b = Noah::Service.create(:name => @service_name, :status => 'pending', :host => a)
        sleep(3)
        put "/services/#{@service_name}/#{@host_name}", @payload.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "update"
        response["id"].nil?.should == false
        response["name"].should == @service_name
        response["host"]["name"].should == @host_name
        response["host"]["status"].should == 'up'
        response["host"]["action"].should == 'update'
      end
    end

    describe "DELETE" do
      before(:all) do
        Ohm.redis.flushdb
        @h = Noah::Host.create(:name => "h1", :status => "up")
        @h.services << Noah::Service.create(:name => "s1", :status => "up", :host => @h)
        @h.save
        @s = @h.services.first
      end  
      it "service from existing host should work" do
        delete "/services/#{@s.name}/#{@h.name}"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "delete"
        response["id"].should == @s.id
        response["host"].should == @h.name
        response["service"].should == @s.name
      end
      it "all entries for a valid service" do
        all_svc_name = 'my_sample_service'
        foo_svc_name = 'my_sample_service_two'
        bar_svc_name = 'my_sample_service_three'
        %w[foo bar baz].each do |host|
          h = Noah::Host.create(:name => host, :status => "up")
          Noah::Service.create(:name => all_svc_name, :status => 'up', :host => h)
        end
        foo_host = Noah::Host.find(:name => 'foo').first
        bar_host = Noah::Host.find(:name => 'bar').first
        Noah::Service.create(:name => foo_svc_name, :status => 'down', :host => foo_host)
        Noah::Service.create(:name => bar_svc_name, :status => 'pending', :host => bar_host)
        
        delete "/services/#{all_svc_name}"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "delete"
        response["affected_hosts"].should == 3

        delete "/services/#{foo_svc_name}"
        last_response.should be_ok
        response = last_response.should return_json
        response["affected_hosts"].should == 1
      end
      it "service for invalid host should not work" do
        delete "/services/#{@s.name}/#{@h.name}"
        last_response.should be_missing
      end
      it "invalid service for valid host should not work" do
        Noah::Host.create(:name => 'valid_host', :status => 'up')
        delete "/services/not_really_here/valid_host"
        last_response.should be_missing
      end
      it "all entries for an invalid service should not_work" do
        delete "/services/not_really_here"
        last_response.should be_missing
      end
    end
  
  end
end  
