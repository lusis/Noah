require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Configuration Model", :reset_redis => true do
  before(:each) do
    Ohm.redis.flushdb
    @appconf_string = {:name => "mystringconf", :format => "string", :body => "some_var"}
    @appconf_json = {:name => "myjsonconf", :format => "json", :body => @appconf_string.to_json}
    @appconf_missing_name = @appconf_string.reject {|k, v| k == :name}
    @appconf_missing_format = @appconf_string.reject {|k, v| k == :format}
    @appconf_missing_body = @appconf_string.reject {|k, v| k == :body}
  end
  after(:each) do
    Ohm.redis.flushdb
  end

  describe "should" do
    it "create a new Configuration" do
      c = Noah::Configuration.create(@appconf_string)
      c.valid?.should == true
      c.is_new?.should == true
      b = Noah::Configuration[c.id]
      b.should == c
    end
    it "create a new Configuration via find_or_create" do
      c = Noah::Configuration.find_or_create(@appconf_string)
      c.valid?.should == true
      c.is_new?.should == true
      a = Noah::Configuration[c.id]
      a.should == c
    end
    it "update an existing Configuration via find_or_create" do
      c = Noah::Configuration.find_or_create(@appconf_string)
      c.valid?.should == true
      c.is_new?.should == true
      sleep(3)
      c.body = "some_other_var"
      c.save
      c.body.should == "some_other_var"
      c.is_new?.should == false
    end
    it "delete an existing Configuration" do
      a = Noah::Configuration.find_or_create(@appconf_string)
      b = Noah::Configuration.find(@appconf_string).first
      b.should == a
      a.delete
      c = Noah::Configuration.find(@appconf_string).first
      c.nil?.should == true
    end
    it "delete from Application when deleting Configuration" do
      # We have to test this because we override delete in Configuration
      a = Noah::Configuration.find_or_create(@appconf_string)
      b = Noah::Configuration.find(@appconf_string).first
      c = Noah::Application.create(:name => "somerandomapp1234")
      c.configurations << a
      b.should == a
      a.delete
      d = Noah::Configuration.find(@appconf_string).first
      d.nil?.should == true
      a.affected_applications.member?(c.name).should == true
      c.configurations.size.should == 0
    end
    it "return all Configurations" do
      a = Noah::Configuration.find_or_create(@appconf_string)
      b = Noah::Configuration.find_or_create(@appconf_json)
      c = Noah::Configurations.all
      c.class.to_s.should == 'Hash'
      c.size.should == 2
      c.has_key?(a.name.to_s).should == true
      c.has_key?(b.name.to_s).should == true
    end

    it "return all Configurations in short form" do
      a = Noah::Configuration.find_or_create(@appconf_string)
      b = Noah::Configuration.find_or_create(@appconf_json)
      c = Noah::Configurations.all({},true)
      c.class.to_s.should == 'Hash'
      c.size.should == 2
      c.has_key?(a.name.to_s).should == true
      c.has_key?(b.name.to_s).should == true
      c.each {|k,v| v.keys.map {|k| k.to_s}.sort.should == ['created_at','format','updated_at']}
    end

    it "should allow for multiple configrations values with the same name with different applications" do
      a1 = Noah::Application.create(:name => "test-app-1")
      a1.valid?.should == true
      a1.is_new?.should == true
      b1 = Noah::Application.find(:name => "test-app-1").first
      b1.should == a1

      a2 = Noah::Application.create(:name => "test-app-2")
      a2.valid?.should == true
      a2.is_new?.should == true
      b2 = Noah::Application.find(:name => "test-app-2").first
      b2.should == a2

      c1 = Noah::Configuration.create(@appconf_string.merge(:application_id => a1.id))
      c2 = Noah::Configuration.create(@appconf_string.merge(:application_id => a2.id))

      c1.valid?.should == true
      c1.is_new?.should == true
      b1 = Noah::Configuration[c1.id]
      b1.should == c1

      c2.valid?.should == true
      c2.is_new?.should == true
      b2 = Noah::Configuration[c2.id]
      b2.should == c2
    end

  end

  describe "should not" do
    it "create a new Configuration without a name" do
      a = Noah::Configuration.create(@appconf_missing_name)
      a.valid?.should == false
      a.errors.should == [[:name, :not_present]]
    end
    it "create a new Configuration without a format" do
      a = Noah::Configuration.create(@appconf_missing_format)
      a.valid?.should == false
      a.errors.should == [[:format, :not_present]]
    end
    it "create a new Configuration without a body" do
      a = Noah::Configuration.create(@appconf_missing_body)
      a.valid?.should == false
      a.errors.should == [[:body, :not_present]]
    end
    it "create a duplicate Configuration" do
      a = Noah::Configuration.create(@appconf_string)
      b = Noah::Configuration.create(@appconf_string)
      b.errors.should == [[[:application_id, :name], :not_unique]]
    end
  end

end
