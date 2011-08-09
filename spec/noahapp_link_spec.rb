require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Link API", :reset_redis => true do
  before(:each) do
    Ohm.redis.flushdb
    @link_name = {"link_name"=>"rspec_org"}
    @host = Noah::Host.create(:name => 'linked_host', :status => 'up')
    @service = Noah::Service.create(:name => 'linked_service', :status => 'down', :host_id => @host.id)
    @application = Noah::Application.create(:name => 'linked_application')
    @configuration = Noah::Configuration.create(:name => 'linked_configuration', :format => 'string', :body => 'some_string')
    @ephemeral = Noah::Ephemeral.create(:path => '/tagged/ephemeral')
  end
  after(:each) do
    Ohm.redis.flushdb
  end  

  describe "calling" do

    describe "PUT" do
      ['host', 'service', 'application', 'configuration', 'ephemeral'].each do |primitive|
        it "link to #{primitive} should work" do
          obj = instance_variable_get("@#{primitive}")
          case primitive
          when "ephemeral"
            put "/#{primitive}s#{obj.path}/link", @link_name.to_json
          when "service"
            put "/#{primitive}s/#{obj.name}/#{@host.name}/link", @link_name.to_json
          else
            put "/#{primitive}s/#{obj.name}/link", @link_name.to_json
          end
          last_response.should be_ok
          response = last_response.should return_json
          response['links'][0].should == @link_name["link_name"]
        end
      end
    end

    describe "DELETE" do
#      ['host', 'service', 'application', 'configuration', 'ephemeral'].each do |primitive|
#        it "multiple tags from #{primitive} should work" do
#          obj = instance_variable_get("@#{primitive}")
#          case primitive
#          when "ephemeral"
#            delete "/#{primitive}s#{obj.path}/tag", @multi_tags.to_json
#          when "service"
#            delete "/#{primitive}s/#{obj.name}/#{@host.name}/tag", @multi_tags.to_json
#          else
#            delete "/#{primitive}s/#{obj.name}/tag", @multi_tags.to_json
#          end
#          last_response.should be_ok
#          response = last_response.should return_json
#          response['tags'].sort.should_not == @multi_tags["tags"].sort
#          response['tags'].size.should == 0
#        end
#      end
    end
  end
end
