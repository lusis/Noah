require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

SAMPLE_YAML = <<EOY
development:
  database: development_database
  adapter: mysql
  username: dev_user
  password: dev_password
EOY

SAMPLE_JSON = <<EOJ
{
  "id":"hostname",
  "data":"localhost"
}
EOJ

describe "Using the Configuration API", :reset_redis => true, :populate_sample_data => false do
  describe "calling" do
    before(:each) do
      Ohm.redis.flushdb
      @redis_config = Noah::Configuration.create(:name => 'redis_url', :format => 'string', :body => 'redis://127.0.0.1:6379/0')
      @json_config = Noah::Configuration.create(:name => 'json_config', :format => 'json', :body => SAMPLE_JSON)
      @yaml_config = Noah::Configuration.create(:name => 'yaml_config', :format => 'yaml', :body => SAMPLE_YAML)
      @sample_application = Noah::Application.create(:name => 'rspec_application')
    end
    after(:each) do
      Ohm.redis.flushdb
    end

    describe "GET" do
      it "all configurations should work" do
        get '/configurations'
        last_response.should be_ok
        response = last_response.should return_json
        response.keys.size.should == 3
        %w[redis_url json_config yaml_config].each do |c|
          response.keys.member?(c).should == true
          %w[id tags links format body created_at updated_at].each do |ck|
            response[c].keys.member?(ck).should == true
          end
        end
      end
      it "named configuration should work" do
        get '/configurations/redis_url'
        last_response.should be_ok
        response = last_response.should return_json
        response.is_a?(Hash).should == true
        response['name'].should == @redis_config.name
        response['id'].should == @redis_config.id
        response["format"].should == @redis_config.format
        response["body"].should == @redis_config.body
        response["tags"].size.should == 0
        response["links"].size.should == 0
      end
      it "named configuration should work with mime-type" do
        require 'yaml'
        get '/configurations/yaml_config/data'
        last_response.should be_ok
        last_response.headers["Content-Type"].should == "text/x-yaml;charset=utf-8"
        response = YAML.load(last_response.body)
        response.is_a?(Hash).should == true
        response.keys.should == ["development"]
        response["development"].keys.sort.should == ["adapter", "database", "password", "username"]
        response["development"].values.sort.should == ["dev_password", "dev_user", "development_database", "mysql"]
      end
      it "invalid configuration should not work" do
        get '/configurations/badconfig'
        last_response.should be_missing
      end  
      it "invalid configuration data should not work" do
        get '/configurations/badconfig/data'
        last_response.should be_missing
      end  
    end

    describe "PUT" do
      it "new configuration should work" do
        config_data = {:format => "string", :body => "sample_config_entry"}.to_json
        put '/configurations/newconfig', config_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "create"
        response["item"].should == "newconfig"
      end
      it "existing configuration should work" do
        config_data = {:format => "string", :body => "sample_config_entry"}.to_json
        put '/configurations/newconfig', config_data, "CONTENT_TYPE" => "application/json"
        sleep 3
        put '/configurations/newconfig', config_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "update"
        response["item"].should == "newconfig"
      end
      it "new configuration with missing format should not work" do
        config_data = {:body => "a string"}.to_json
        put '/configurations/someconfig', config_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end
      it "new configuration with missing body should not work" do
        config_data = {:body => "a string"}.to_json
        put '/configurations/someconfig', config_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end  
    end

    describe "DELETE" do
      it "existing configuration should work" do
        @a = Noah::Application.create(:name => 'delete_test_app')
        cparms = {:name => 'asdf', :format => 'string', :body => 'asdf'}
        @c = Noah::Configuration.create(cparms)
        @a.configurations << @c
        get "/configurations/asdf"
        delete "/configurations/#{@c.name}"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["id"].should == @c.id
        response["action"].should == "delete"
        response["affected_applications"].member?(@a.name).should == true
        response["item"].should == @c.name
      end
      it "invalid configuration should not work" do
        delete "/configurations/somethingthatshouldnotexist"
        last_response.should be_missing
      end
    end

  end
end  
