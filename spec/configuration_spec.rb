require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Configuration Model", :reset_redis => true do
  before(:all) do
    @appdata1 = {:name => "my_application"}
    @appconf_string = {:name => "mystringconf", :format => "string", :body => "some_var"}
    @appconf_json = {:name => "myjsonconf", :format => "json", :body => @appconf_string.to_json}
  end
  before(:each) do
    Ohm.redis.flushdb
  end
  after(:each) do
    Ohm.redis.flushdb
  end  
  describe "should" do
    
    it "create a new Configuration" do
      c = Configuration.create(@appconf_string)
      c.valid?.should == true
      c.is_new?.should == true
      b = Configuration[c.id]
      b.should == c
    end
    it "create a new Configuration via find_or_create" do
      c = Configuration.find_or_create(@appconf_string)
      c.valid?.should == true
      c.is_new?.should == true
      a = Configuration[c.id]
      a.should == c
    end
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
