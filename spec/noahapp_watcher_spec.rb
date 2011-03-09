require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Watcher API", :reset_redis => true do
  before(:each) do
    endpoint = 'http://localhost:4567/webhook'
    Ohm.redis.flushdb
    a = Noah::Application.create :name => 'fooapp'
    a.watch! :endpoint => endpoint
    c = Noah::Configuration.create :name => 'fooconfig'
    c.watch! :endpoint => endpoint
    h = Noah::Host.create :name => 'localhost', :status => 'up'
    h.watch! :endpoint => endpoint
    s = Noah::Service.create :name => 'localhostservice', :status => 'up', :host => h
    s.watch! :endpoint => endpoint
  end

  after(:all) do
    Ohm.redis.flushdb
  end

  describe "calling" do

    describe "GET" do
      it "all watches should work" do
        get '/w'
        last_response.should be_ok
        response = last_response.should return_json
        response.is_a?(Array).should == true
        response.size.should == 4
      end
    end

  end
end  
