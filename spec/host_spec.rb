require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Host", :reset_redis => true do

  it "should create a new Host with no services" do
    hostname = "host1.domain.com"
    status = "up"
    host = Host.create(:name => hostname, :status => status)
    host.valid?.should == true
    host.save
    host.name.should == hostname
    host.status.should == status
    host.services.size.should == 0
  end

  it "should create a new Host with services" do
    hostname = "host2.domain.com"
    hoststatus = "down"
    servicename = 'myservice'
    servicestatus = 'pending'
    host = Host.create(:name => hostname, :status => hoststatus)
    host.valid?.should == true
    host.save
    host.services << Service.create(:name => servicename, :status => servicestatus, :host => host)
    host.name.should == hostname
    host.status.should == hoststatus
    host.services.size.should == 1
    host.services[1].valid?.should == true
    host.services[1].name.should == servicename
    host.services[1].status.should == servicestatus
    host.services[1].host_id.should == host.id
  end

end
