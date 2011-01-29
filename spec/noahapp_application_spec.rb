require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Application API", :reset_redis => false, :populate_sample_data => true do
  describe "calling" do

    describe "GET" do
      it "all applications should work"
      it "named application should work"
      it "named configuration for application should work"
      it "named configuration should work with mime-type"
      it "invalud application should not work"
      it "invalid configuration for application should not work"
    end

    describe "PUT" do
      it "new application should work"
      it "new application with missing name should not work"
      it "existing application should work"
    end

    describe "DELETE" do
      it "existing application should work"
      it "invalid application should not work"
    end

  end
end  
