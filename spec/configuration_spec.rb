require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Configuration Model", :reset_redis => true do

  describe "should" do
    
    it "create a new Configuration"
    it "create a new Configuration via find_or_create"
    it "update an existing Configuration via find_or_create"
    it "delete an existing Configuration"
    it "return all Configurations"
  
  end

  describe "should not" do

    it "create a new Configuration without a name"
    it "create a new Configuration without a format"
    it "create a new Configuration without a body"
    it "create a new Configuration without an Application"
    it "create a duplicate Configuration"

  end

end
