require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Watcher Model", :reset_redis => true do
  before(:each) do
    Ohm.redis.flushdb
    @test_endpoint = "http://localhost/webhook"
    @test_pattern = "/foo/bar"
    Noah::Watcher.create :pattern => @test_pattern, :endpoint => @test_webhook
    @test_watch = Noah::Watcher.new :endpoint => "http://localhost/webhook"
  end
  after(:each) do
    #Ohm.redis.flushdb
  end

  describe "should" do
    it "create a new Noah::Watcher" do
      @test_watch.pattern = "/snarf"
      @test_watch.valid?.should == true
      @test_watch.save
      a = Noah::Watcher.find(:endpoint => @test_watch.endpoint, :pattern => @test_watch.pattern).first
      a.should == @test_watch
    end
    it "delete an existing Noah::Watcher" do
      @test_watch.pattern = "/snarf"
      @test_watch.save
      @test_watch.delete
      Noah::Watcher.find(:endpoint => @test_endpoint, :pattern => @test_pattern).first.should == nil
    end
  end

  describe "should not" do
    it "create a new Noah::Watcher with missing endpoint" do
      a = Noah::Watcher.create(:pattern => "/foo/bar")
      a.valid?.should == false
      a.errors.should == [[:endpoint, :not_present]]
    end
    it "create a new Noah::Watcher with missing pattern" do
      a = Noah::Watcher.create(:endpoint => "http://localhost/webhook")
      a.valid?.should == false
      a.errors.should == [[:pattern, :not_present]]
    end
    it "create a new Noah::Watcher with subset pattern" do
      a = Noah::Watcher.create(:endpoint => "http://localhost.domain.com/webhook", :pattern => "//noah/")
      b = Noah::Watcher.create(:endpoint => "http://localhost.domain.com/webhook", :pattern => "//noah/foobar")
      b.valid?.should == false
      b.errors.should == [[:pattern, :already_provided]]
    end
    it "create a new Noah::Watcher with superset pattern" do
      a = Noah::Watcher.create(:endpoint => "http://localhost.domain.com/webhook", :pattern => "//noah/foobar")
      b = Noah::Watcher.create(:endpoint => "http://localhost.domain.com/webhook", :pattern => "//noah")
      b.valid?.should == false
      b.errors.should == [[:pattern, :replaces_existing]]
    end
    it "create a duplicate Noah::Watcher" do
      a = Noah::Watcher.create(:endpoint => "http://localhost.domain.com/webhook", :pattern => "//noah/foobar")
      b = Noah::Watcher.create(:endpoint => "http://localhost.domain.com/webhook", :pattern => "//noah/foobar")
      b.valid?.should == false
      b.errors.should == [[[:endpoint, :pattern], :not_unique]]
    end
  end

end
