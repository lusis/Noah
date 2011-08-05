require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Tag API", :reset_redis => true do
  before(:each) do
    Ohm.redis.flushdb
    @multi_tags = {"tags"=>["production", "databases", "in-service"]}
    @single_tag = {"tags"=>"out-of-service"}
    @host = Noah::Host.create(:name => 'tagged_host', :status => 'up')
    @service = Noah::Service.create(:name => 'tagged_service', :status => 'down', :host_id => @host.id)
    @application = Noah::Application.create(:name => 'tagged_application')
    @configuration = Noah::Configuration.create(:name => 'tagged_configuration', :format => 'string', :body => 'some_string')
    @ephemeral = Noah::Ephemeral.create(:path => '/tagged/ephemeral')
  end
  after(:each) do
    Ohm.redis.flushdb
  end  

  describe "calling" do

    describe "PUT" do
      ['host', 'service', 'application', 'configuration', 'ephemeral'].each do |primitive|
        it "multiple tags to #{primitive} should work" do
          obj = instance_variable_get("@#{primitive}")
          case primitive
          when "ephemeral"
            put "/#{primitive}s#{obj.path}/tag", @multi_tags.to_json
          when "service"
            put "/#{primitive}s/#{obj.name}/#{@host.name}/tag", @multi_tags.to_json
          else
            put "/#{primitive}s/#{obj.name}/tag", @multi_tags.to_json
          end
          last_response.should be_ok
          response = last_response.should return_json
          response['tags'].sort.should == @multi_tags["tags"].sort
        end
      end

      ['host', 'service', 'application', 'configuration', 'ephemeral'].each do |primitive|
        it "single tag to #{primitive} should work" do
          obj = instance_variable_get("@#{primitive}")
          case primitive
          when "ephemeral"
            put "/#{primitive}s#{obj.path}/tag", @single_tag.to_json
          when "service"
            put "/#{primitive}s/#{obj.name}/#{@host.name}/tag", @single_tag.to_json
          else
            put "/#{primitive}s/#{obj.name}/tag", @single_tag.to_json
          end
          last_response.should be_ok
          response = last_response.should return_json
          response['tags'].should == [@single_tag["tags"]]
        end
      end
    end

    describe "DELETE" do
      ['host', 'service', 'application', 'configuration', 'ephemeral'].each do |primitive|
        it "multiple tags from #{primitive} should work" do
          obj = instance_variable_get("@#{primitive}")
          case primitive
          when "ephemeral"
            delete "/#{primitive}s#{obj.path}/tag", @multi_tags.to_json
          when "service"
            delete "/#{primitive}s/#{obj.name}/#{@host.name}/tag", @multi_tags.to_json
          else
            delete "/#{primitive}s/#{obj.name}/tag", @multi_tags.to_json
          end
          last_response.should be_ok
          response = last_response.should return_json
          response['tags'].sort.should_not == @multi_tags["tags"].sort
          response['tags'].size.should == 0
        end
      end

      ['host', 'service', 'application', 'configuration', 'ephemeral'].each do |primitive|
        it "single tag from #{primitive} should work" do
          obj = instance_variable_get("@#{primitive}")
          case primitive
          when "ephemeral"
            delete "/#{primitive}s#{obj.path}/tag", @single_tag.to_json
          when "service"
            delete "/#{primitive}s/#{obj.name}/#{@host.name}/tag", @single_tag.to_json
          else
            delete "/#{primitive}s/#{obj.name}/tag", @single_tag.to_json
          end
          last_response.should be_ok
          response = last_response.should return_json
          response['tags'].should_not == [@single_tag["tags"]]
          response['tags'].size.should == 0
        end
      end
    end
  end
end
