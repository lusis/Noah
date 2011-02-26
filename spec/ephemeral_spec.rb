require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Ephemeral Model", :reset_redis => true do
  before(:all) do
    @edata = {:path => "/foo/bar/baz", :data => "some_value"}
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
      b = Noah::Ephemeral[@good_ephemeral.id]
      b.should == @good_ephemeral
    end
    it "create a new Noah::Ephemeral with missing data" do
      @missing_data.valid?.should == true
      @missing_data.save
      b = Noah::Ephemeral[@missing_data.id]
      b.should == @missing_data
    end
#    it "update an existing Noah::Ephemeral" do
#      @good_ephemeral.save
#      Noah::Ephemeral.all.size.should == 1
#      c = Noah::Ephemeral[@good_ephemeral.id]
#      c.data = "updated_data"
#      c.save
#      sleep(2)
#      c.is_new?.should == false
#    end
    it "delete an existing Noah::Ephemeral" do
      @good_ephemeral.save
      @good_ephemeral.delete
      Noah::Ephemeral[@good_ephemeral.id].should == nil
    end
  end
  describe "should not" do
    it "create a new Noah::Ephemeral with missing path" do
      @missing_path.valid?.should == false
      @missing_path.errors.should == [[:path, :not_present]]
    end
  end
end
