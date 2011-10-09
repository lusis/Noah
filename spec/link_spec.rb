require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Link Model", :reset_redis => true do
  before(:each) do
    Ohm.redis.flushdb
    @link = "/myorg"
    @host = Noah::Host.create(:name => 'linked_host', :status => 'up')
    @service = Noah::Service.create(:name => 'linked_service', :status => 'down', :host_id => @host.id)
    @application = Noah::Application.create(:name => "linked_application")
    @configuration = Noah::Configuration.create(:name => "linked_configuration", :format => "string", :body => "some_string")
    @ephemeral = Noah::Ephemeral.create(:path => "/linked/ephemeral")
  end
  after(:each) do
    Ohm.redis.flushdb
  end

  describe "should" do
    it "create a new Noah::Link" do
      l = Noah::Link.new(:path => @link)
      l.valid?.should == true
      l.save
      l.is_new?.should == true
      xl = Noah::Link.find(:path => @link).first
      xl.should == l
    end
    it "create a new Noah::Link and add a single member" do
      l = Noah::Link.create(:path => @link)
      l.nodes = @host
      @host.links.member?(l).should == true
      @host.links.size.should == 1
      l.nodes.size.should == 1
      l.nodes.member?(@host.key).should == true
    end

    it "create a new Noah::Link and add multiple members" do
      l = Noah::Link.create(:path => @link)
      l.nodes = [@host, @service, @application, @configuration, @ephemeral]
      l.nodes.size.should == 5
      [@host, @service, @application, @configuration, @ephemeral].each do |node|
        l.nodes.member?(node.key).should == true
        node.links.member?(l).should == true
        node.links.size.should == 1
      end
    end
    it "link! an existing object to a single link" do
      @host.link!(@link)
      l = Noah::Link.find(:path => @link).first
      @host.links.member?(l).should == true
      @host.links.size.should == 1
      l.nodes.member?(@host.key).should == true
      l.nodes.size.should == 1
    end
    it "return a hash of all nodes" do
      l = Noah::Link.create(:path => @link)
      l.nodes = [@host, @service, @application, @configuration, @ephemeral]
      h = l.to_hash
      h[:id].should == l.id
      h[:name].should == l.name
      h[:updated_at].should == l.updated_at
      h[:created_at].should == l.created_at
      h[:hosts].has_key?(@host.name.to_s).should == true
      h[:hosts]["#{@host.name}"].keys.map {|k| k.to_s}.sort.should == [:id, :status, :tags, :services].map {|k| k.to_s}.sort
      h[:services].has_key?(@service.name.to_s).should == true
      h[:services]["#{@service.name}"]["#{@host.name}"].keys.map {|k| k.to_s}.sort.should == [:id, :status, :tags].map {|k| k.to_s}.sort
      h[:applications].has_key?(@application.name.to_s).should == true
      h[:applications]["#{@application.name}"].keys.map {|k| k.to_s}.sort.should == [:id, :tags, :configurations].map {|k| k.to_s}.sort
      h[:configurations].has_key?(@configuration.name.to_s).should == true
      h[:configurations]["#{@configuration.name}"].keys.map {|k| k.to_s }.sort.should == [:id, :tags, :format, :body].map {|k| k.to_s}.sort
      h[:ephemerals].has_key?(@ephemeral.name.to_s).should == true
      h[:ephemerals]["#{@ephemeral.name}"].keys.map {|k| k.to_s}.sort.should == [:id, :tags, :path, :data].map {|k| k.to_s}.sort

    end
  end
  describe "should not" do
    it "create a new Noah::Link without a path" do
      l = Noah::Link.create
      l.valid?.should == false
      l.errors.should == [[:path, :not_present]]
    end
    it "create a link with a duplicate name" do
      l = Noah::Link.create(:path => @link)
      ln = Noah::Link.create(:path => @link)
      ln.valid?.should == false
      ln.errors.should == [[:path, :not_unique]]
    end
  end
end
