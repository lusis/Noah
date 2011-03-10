require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Ephemeral API", :reset_redis => true do
  before(:each) do
    Ohm.redis.flushdb
    Noah::Ephemeral.create(:path => "/foo/bar/baz", :data => "value1")
    Noah::Ephemeral.create(:path => "/baz/bar")
  end
  after(:each) do
    Ohm.redis.flushdb
  end
  describe "calling" do

    describe "GET" do
      it "all ephemerals should return 404" do
        get '/e'
        last_response.should_not be_ok
        last_response.status.should == 404
        response = last_response.should return_json
        response['error_message'].should == 'Resource not found'
        response['result'].should == 'failure'
      end

      it "named path with data should work" do
        get '/e/foo/bar/baz'
        last_response.should be_ok
        last_response.body.should == 'value1'
      end

      it "named path without data should work" do
        get '/e/baz/bar'
        last_response.status.should == 200
        last_response.body.should == ""
      end

      it "invalid path should not work" do
        get '/e/ssss/dddd'
        last_response.should_not be_ok
        last_response.status.should == 404
        response = last_response.should return_json
        response['error_message'].should == 'Resource not found'
        response['result'].should == 'failure'
      end
    end

    describe "PUT" do
      it "new ephemeral with data should work" do
        put '/e/whiz/bang/', 'value3'
        last_response.should be_ok
        response = last_response.should return_json
        response['result'].should == 'success'
        response['id'].nil?.should == false
        response['path'].should == '/whiz/bang/'
        response['data'].should == 'value3'
      end

      it "new ephemeral without data should work" do
        put '/e/bang/whiz'
        last_response.should be_ok
        response = last_response.should return_json
        response['result'].should == 'success'
        response['action'].should == 'create'
        response['id'].nil?.should == false
        response['path'].should == '/bang/whiz'
        response['data'].should == nil
      end

      it "existing ephemeral with data should work"
      it "existing ephemeral without data should work"
    end

    describe "DELETE" do
      it "existing path should work" do
        e = Noah::Ephemeral.new(:path => '/slart/i/bart/fast', :data => 'someddata')
        e.save
        delete "/e/slart/i/bart/fast"
        last_response.should be_ok
        response = last_response.should return_json
        response['result'].should == 'success'
        response['action'].should == 'delete'
        response['id'].should == e.id
        response['path'].should == e.name
      end

      it "invalid path should not work" do
        delete '/e/fork/spoon/knife'
        last_response.should_not be_ok
        last_response.status.should == 404
        response = last_response.should return_json
        response['error_message'].should == 'Resource not found'
        response['result'].should == 'failure'
      end
    end
  end
end
