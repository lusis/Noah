require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Ephemeral Model", :reset_redis => true do
  before(:all) do
    @edata = {:path => "//noah/foo/bar/baz", :data => "some_value"}
    @emissing_path = @edata.reject {|x| x == :path}
    @emissing_data = @edata.reject {|x| x == :data}
    @good_ephemeral = Noah::Ephemeral.new(@edata)
    @missing_path = Noah::Ephemeral.new(@emissing_path)
    @missing_data = Noah::Ephemeral.new(@emissing_data)
  end
  before(:each) do
    Ohm.redis.flushdb
  end
  after(:each) do
    Ohm.redis.flushdb
  end
  describe "should" do
    it "create a new Noah::Ephemeral" do
      @good_ephemeral.valid?.should == true
      @good_ephemeral.save
      b = Noah::Ephemeral.find(:path => @edata[:path]).first
      b.should == @good_ephemeral
    end
    it "create a new Noah::Ephemeral with missing data"
    it "update an existing Noah::Ephemeral"
    it "delete an existing Noah::Ephemeral"
  end
  describe "should not" do
    it "create a new Noah::Ephemeral with missing path"
  end
end
