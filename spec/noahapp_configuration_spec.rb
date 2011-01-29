require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Configuration API", :reset_redis => false, :populate_sample_data => true do
  describe "calling" do

    describe "GET" do
      it "all configurations should work"
      it "named application should work"
      it "named configuration for application should work"
      it "named configuration should work with mime-type"
      it "invalid application should not work"
      it "invalid configuration for application should not work"
    end

    describe "PUT" do
      it "new configuration should work"
      it "existing configuration should work"
      it "new configuration with missing format should not work"
      it "new configuration with missing body should not work"
    end

    describe "DELETE" do
      it "existing configuration should work"
      it "invalid configuration should not work"
    end

  end
end  
