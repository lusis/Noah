require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Application Model", :reset_redis => true do
  before(:all) do
    @appdata1 = {:name => "my_application"}
    @appdata2 = {:name => "my_other_app"}
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
    it "create a new Application" do
      a = Application.create(@appdata1)
      a.valid?.should == true
      a.is_new?.should == true
      b = Application.find(@appdata1).first
      b.should == a
    end
    it "create a new Application with Configurations" do
      a = Application.create(@appdata1)
      a.configurations << Configuration.create(@appconf_string.merge({:application => a}))
      a.valid?.should == true
      a.is_new?.should == true
      a.save
      b = Application.find(@appdata1).first
      b.should == a
      b.configurations.size.should == 1
      b.configurations.first.name.should == @appconf_string[:name]
      b.configurations.first.format.should == @appconf_string[:format]
      b.configurations.first.body.should == @appconf_string[:body]
    end  
    it "create a new Application via find_or_create" do
      a = Application.find_or_create(@appdata2)
      a.valid?.should == true
      a.is_new?.should == true
      b = Application.find(@appdata2).first
      b.should == a
    end
    it "update an existing Application via find_or_create" do
      a = Application.create(@appdata1)
      a.is_new?.should == true
      sleep 2
      b = Application.find_or_create(@appdata1)
      b.is_new?.should == false
    end
    it "delete an existing Application" do
      a = Application.create(@appdata1)
      b = Application.find(@appdata1).first
      b.should == a
      b.delete
      c = Application.find(@appdata1).first
      c.nil?.should == true
    end  
    it "return all Applications" do
      a = Application.create(@appdata1)
      b = Application.create(@appdata2)
      c = Applications.all
      c.size.should == 2
      c.member?(a).should == true
      c.member?(b).should == true
    end  
  end

  describe "should not" do
    it "should not create a new Application without a name" do
      a = Application.create
      a.valid?.should == false
      a.errors.should == [[:name, :not_present]]
    end
    it "should not create a duplicate Application" do
      a = Application.create(@appdata1)
      a.valid?.should == true
      b = Application.create(@appdata1)
      b.valid?.should == false
      b.errors.should == [[:name, :not_unique]]
    end
  end
end  
