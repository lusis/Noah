require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Service API", :reset_redis => false, :populate_sample_data => true do
  describe "calling" do
    
    describe "GET" do
      it "all services should work"
      it "all named services should work"
      it "named service for host should work"
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
      it "existing host should work"
      it "invalid host should not work"
    end
  
  end
end  
