require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Service", :reset_redis => true do

  it "should create a new Service" do
    servicename = "myservice"
    servicestatus = "up"
    hostname = "mytesthost1"
    hoststatus = "up"
    host = Host.create(:name => hostname, :status => hoststatus)
    host.save
    service = Service.create(:name => "myservice", :status => "up", :host => host)
    service.valid?.should == true
    service.save
    service.name.should == servicename
    service.status.should == servicestatus
    service.host_id.should == host.id
    host.services[1].name.should == servicename
  end  

end
