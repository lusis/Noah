require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Tag Model", :reset_redis => true do
  before(:each) do
    Ohm.redis.flushdb
    @tags1 = ["production", "databases", "in-service"]
    @tags2 = "out-of-service"
    @host = Noah::Host.create(:name => 'tagged_host', :status => 'up')
    @service = Noah::Service.create(:name => 'tagged_service', :status => 'down', :host_id => @host.id)
    @application = Noah::Application.create(:name => 'tagged_application')
    @configuration = Noah::Configuration.create(:name => 'tagged_configuration')
    @ephemeral = Noah::Ephemeral.create(:path => '/tagged/ephemeral')
  end
  after(:each) do
    Ohm.redis.flushdb
  end  
  describe "should" do
    it "create a new Noah::Tag" do
      t = Noah::Tag.new(:name => 'some_tag')
      t.valid?.should == true
      t.save
      t.is_new?.should == true
      b = Noah::Tag.find(:name => 'some_tag').first
      b.should == t
    end
    it "create a new Noah::Tag and add a member" do
      t = Noah::Tag.create(:name => 'some_tag')
      t.members = @host
      @host.tags.member?(t).should == true
      t.members[:hosts].size.should == 1
      t.members[:hosts].member?(@host.name).should == true
    end
    it "tag! an existing object with a single tag" do
      @host.tag! @tags2
      t = Noah::Tag.find(:name => @tags2).first
      @host.tags.member?(t).should == true
      t.members[:hosts].size.should == 1
      t.members[:hosts].member?(@host.name).should == true
    end
    it "tag! an existing object with an array of tags" do
      @host.tag! @tags1
      @tags1.each do |tag|
        t = Noah::Tag.find(:name => tag).first
        @host.tags.member?(t).should == true
        t.members[:hosts].size.should == 1
        t.members[:hosts].member?(@host.name).should == true
      end
      Noah::Tag.all.size.should == 3
    end
    it "find all objects tagged"
    it "support tagging all object types"
  end

  describe "should not" do
    it "should not create a new Noah::Tag without a name" do
      a = Noah::Tag.create
      a.valid?.should == false
      a.errors.should == [[:name, :not_present]]
    end
  end
end  
