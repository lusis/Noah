require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Tag Model", :reset_redis => true do
  before(:each) do
    Ohm.redis.flushdb
    @tags1 = ["production", "databases", "in-service"]
    @tags2 = "out-of-service"
    @host = Noah::Host.create(:name => 'tagged_host', :status => 'up')
    @service = Noah::Service.create(:name => 'tagged_service', :status => 'down', :host_id => @host.id)
    @application = Noah::Application.create(:name => 'tagged_application')
    @configuration = Noah::Configuration.create(:name => 'tagged_configuration', :format => 'string', :body => 'some_string')
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
      t.members[:hosts].member?(@host).should == true
    end
    it "tag! an existing object with a single tag" do
      @host.tag! @tags2
      t = Noah::Tag.find(:name => @tags2).first
      @host.tags.member?(t).should == true
      t.members[:hosts].size.should == 1
      t.members[:hosts].member?(@host).should == true
    end
    it "tag! an existing object with an array of tags" do
      @host.tag! @tags1
      @tags1.each do |tag|
        t = Noah::Tag.find(:name => tag).first
        @host.tags.member?(t).should == true
        t.members[:hosts].size.should == 1
        t.members[:hosts].member?(@host).should == true
      end
      Noah::Tag.all.size.should == 3
    end
    it "tag all object types and find via tagged" do
      @host.tag! @tags1
      @ephemeral.tag! @tags1
      @configuration.tag! @tags1
      @application.tag! @tags1
      @service.tag! @tags1
      @tags1.each do |tag|
        Noah::Tags.tagged(tag).size.should == 5
        [@host, @service, @application, @configuration, @ephemeral].each do |o|
          Noah::Tags.tagged(tag).values.flatten.member?(o).should == true
        end
      end
    end
  end

  describe "should not" do
    it "create a new Noah::Tag without a name" do
      a = Noah::Tag.create
      a.valid?.should == false
      a.errors.should == [[:name, :not_present]]
    end
    it "create a tag with a duplicate name" do
      a = Noah::Tag.create(:name => 'tag1')
      b = Noah::Tag.create(:name => 'tag1')
      b.valid?.should == false
      b.errors.should == [[:name, :not_unique]]
    end
  end
end  
