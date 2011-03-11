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

      it "named watch should work" do
        w = Noah::Watcher.create(:pattern => '//noah/application/myapp', :endpoint => 'http://localhost/webhook')
        get "/w/#{w.name}"
        last_response.should be_ok
        response = last_response.should return_json
        response['pattern'].should == w.pattern
        response['endpoint'].should == w.endpoint
      end

      it "invalid watch should not work" do
        get '/w/asdfasdfasdfasdfasdfsdf'
        last_response.should be_missing
      end
    end

    describe "PUT" do
      it "new watch should work" do
        data = {:pattern => "//noah/application", :endpoint => "http://myendpoint/webhook"}
        put '/w', data.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response['pattern'].should == data[:pattern]
        response['endpoint'].should == data[:endpoint]
        w = Noah::Watcher.find(data).first
        w.pattern.should == data[:pattern]
        w.endpoint.should == data[:endpoint]
      end

      it "new watch without pattern should not work" do
        data = {:endpoint => "http://myendpoint/webhook"}
        put '/w', data.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end

      it "new watch without endpoint should not work" do
        data = {:pattern => "//noah/application"}
        put '/w', data.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end

      it "new watch that supercedes existing should not work" do
        Noah::Watcher.create(:endpoint => 'http://myendpoint/webhook', :pattern => '//noah/application/foo')
        data = {:endpoint => "http://myendpoint/webhook", :pattern => '//noah/application'}
        put '/w', data.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should_not be_ok
        response = last_response.should return_json
        response['error_message'].should == 'Pattern would overwrite existing'
      end

      it "new watch that subsets an existing should not work" do
        Noah::Watcher.create(:endpoint => 'http://myendpoint/webhook', :pattern => '//noah/application')
        data = {:endpoint => "http://myendpoint/webhook", :pattern => '//noah/application/foo'}
        put '/w', data.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should_not be_ok
        response = last_response.should return_json
        response['error_message'].should == 'Pattern is already provided'
      end
    end

    describe "DELETE" do
      it "delete an existing watch should work" do
        data = {:endpoint => "http://myendpoint/webhookd", :pattern => '//noah/application/d'}
        w = Noah::Watcher.create(data)
        delete '/w', data.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response['pattern'].should == data[:pattern]
        response['endpoint'].should == data[:endpoint]
        response['name'].should_not == "null"
        Noah::Watcher.find(data).size.should == 0
      end

      it "delete an invalid watch should not work" do
        data = {:endpoint => 'missing', :pattern => '//noah/application/dag'}
        delete '/w', data.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_missing
      end

      it "delete without pattern should not work" do
        data = {:endpoint => "invalid"}
        delete '/w', data.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end

      it "delete without endpoint should not work" do
        data = {:pattern => "//noah/invalid"}
        delete '/w', data.to_json, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end
    end
  end
end  
