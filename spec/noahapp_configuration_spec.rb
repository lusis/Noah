require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Configuration API", :reset_redis => false, :populate_sample_data => true do
  describe "calling" do

    describe "GET" do
      it "all configurations should work" do
        get '/configurations'
        last_response.should be_ok
        last_response.should return_json
      end
      it "named application should work" do
        get '/configurations/noah'
        last_response.should be_ok
        response = last_response.should return_json

        response.is_a?(Array).should == true
        response.first["name"].should == "redis"
        response.first["format"].should == "string"
        response.first["body"].should == "redis://127.0.0.1:6379/0"
        response.first["application"].should == "noah"
      end
      it "named configuration for application should work" do
        get '/configurations/noah/redis'
        last_response.should be_ok
        response = last_response.body
        response.should == "redis://127.0.0.1:6379/0"
      end
      it "named configuration should work with mime-type" do
        require 'yaml'
        get '/configurations/myrailsapp1/database.yml'
        last_response.should be_ok
        last_response.headers["Content-Type"].should == "text/x-yaml;charset=utf-8"
        response = YAML.load(last_response.body)
        response.is_a?(Hash).should == true
        response.keys.should == ["development"]
        response["development"].keys.sort.should == ["adapter", "database", "password", "username"]
        response["development"].values.sort.should == ["dev_password", "dev_user", "development_database", "mysql"]
      end
      it "invalid application should not work" do
        get '/configurations/badapp'
        last_response.should be_missing
      end  
      it "invalid configuration for application should not work" do
        get '/configurations/badapp/badconfig'
        last_response.should be_missing
      end  
    end

    describe "PUT" do
      it "new configuration should work" do
        config_data = {:format => "string", :body => "sample_config_entry"}.to_json
        put '/configurations/newapp/newconfig', config_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "create"
        response["dependencies"].should == "created"
        response["application"].should == "newapp"
        response["item"].should == "newconfig"
      end
      it "existing configuration should work" do
        config_data = {:format => "string", :body => "sample_config_entry"}.to_json
        sleep 3
        put '/configurations/newapp/newconfig', config_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["action"].should == "update"
        response["dependencies"].should == "updated"
        response["application"].should == "newapp"
        response["item"].should == "newconfig"
      end
      it "new configuration with missing format should not work" do
        config_data = {:body => "a string"}.to_json
        put '/configurations/newnewapp/someconfig', config_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end
      it "new configuration with missing body should not work" do
        config_data = {:body => "a string"}.to_json
        put '/configurations/newnewapp/someconfig', config_data, "CONTENT_TYPE" => "application/json"
        last_response.should be_invalid
      end  
    end

    describe "DELETE" do
      before(:all) do
        @a = Noah::Application.create(:name => 'delete_test_app')
        cparms = {:name => 'a', :format => 'string', :body => 'asdf', :application_id => @a.id}
        @a.configurations << Noah::Configuration.create(cparms)
        @a.save
        @c = @a.configurations.first
      end

      it "existing configuration should work" do
        delete "/configurations/#{@a.name}/#{@c.name}"
        last_response.should be_ok
        response = last_response.should return_json
        response["result"].should == "success"
        response["id"].should == @c.id
        response["action"].should == "delete"
        response["application"].should == @a.name
        response["item"].should == @c.name
      end
      it "invalid configuration should not work" do
        delete "/configurations/#{@a.name}/#{@c.name}"
        last_response.should be_missing
      end
    end

  end
end  
