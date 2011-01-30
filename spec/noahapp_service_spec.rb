require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Service API", :reset_redis => false, :populate_sample_data => true do
  describe "calling" do
    
    describe "GET" do
      it "all services should work"
      it "all named services should work"
      it "named service for host should work"
      it "missing service for host should not work" do
        get '/s/foobar/baz'
        last_response.should be_missing
      end
    end

    describe "PUT" do
      it "new service should work"
      it "new service without host should not work"
      it "new service with invalid status should not work"
      it "new service with missing name should not work"
      it "new service with missing status should not work"
      it "existing service should work"
    end

    describe "DELETE" do
      before(:all) do
        @h = Host.create(:name => "h1", :status => "up")
        @h.services << Service.create(:name => "s1", :status => "up", :host => @h)
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
