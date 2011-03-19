require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Ephemeral Model", :reset_redis => true do
  before(:all) do
    @edata = {:path => "/foo/bar/baz", :data => "some_value"}
    @emissing_path = @edata.reject {|k, v| k == :path}
    @emissing_data = @edata.reject {|k, v| k == :data}
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
      b = Noah::Ephemeral[@good_ephemeral.id]
      b.should == @good_ephemeral
    end
    it "create a new Noah::Ephemeral with missing data" do
      @missing_data.valid?.should == true
      @missing_data.save
      b = Noah::Ephemeral[@missing_data.id]
      b.should == @missing_data
    end
    it "update an existing Noah::Ephemeral" do
      e = Noah::Ephemeral.create :path => "/is/new/test"
      Noah::Ephemeral.all.size.should == 1
      sleep(2)
      c = Noah::Ephemeral[e.id]
      c.data = "updated_data"
      c.save
      c.is_new?.should == false
    end
    it "delete an existing Noah::Ephemeral" do
      @good_ephemeral.save
      @good_ephemeral.delete
      Noah::Ephemeral[@good_ephemeral.id].should == nil
    end
    it "should allow reserved keywords as subpaths" do
      Noah::PROTECTED_PATHS.each do |path|
        e = Noah::Ephemeral.new :path => "/this/should/be/#{path}"
        e.valid?.should == true
      end
    end
  end
  describe "should not" do
    it "create a new Noah::Ephemeral with missing path" do
      e = Noah::Ephemeral.create
      e.valid?.should == false
      e.errors.should == [[:path, :not_present]]
    end
    it "create a duplicate Noah::Ephemeral" do
      e = Noah::Ephemeral.create :path => "/random/path"
      f = Noah::Ephemeral.create :path => "/random/path"
      f.valid?.should == false
      f.errors.should == [[:path, :not_unique]]
    end
    it "allow a reserved keyword as a path" do
      Noah::PROTECTED_PATHS.each do |path|
        e = Noah::Ephemeral.new :path => "/#{path}"
        e.valid?.should == false
        e.errors.should == [[:path, :reserved_path]]
      end
    end
  end
end
