require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Host", :reset_redis => true do

  it "should create a new Host with no services" do
    hostname = "host1.domain.com"
    hoststatus = "up"
    host = Host.create(:name => hostname, :status => hoststatus)
    host.valid?.should == true
    host.save
    host.name.should == hostname
    host.status.should == hoststatus
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

  it "should create a Host via find_or_create" do
    hostname = "host3.domain.com"
    hoststatus = "up"
    host = Host.find_or_create(:name => hostname, :status => hoststatus)
    host.valid?.should == true
    host.save
    host.is_new?.should == true
  end

  it "should update a Host via find_or_create" do
    hostname = "host3.domain.com"
    hoststatus = "pending"
    newstatus = "down"
    host = Host.find_or_create(:name => hostname, :status => hoststatus)
    host.valid?.should == true
    host.save
    host.is_new?.should == true
    sleep 3
    host1 = Host.find_or_create(:name => hostname, :status => newstatus)
    host1.save
    host1.is_new?.should == false
  end

  it "should delete a Host" do
    hostname = "host3.domain.com"
    hoststatus = "pending"
    host = Host.create(:name => hostname, :status => hoststatus)
    host.save
    host.delete
    Host.find(:name => hostname).empty?.should == true
  end  

  it "should not create a new Host with missing status" do
    hostname ="host3.domain.com"
    host = Host.create(:name => hostname)
    host.valid?.should == false
    host.errors.should == [[:status, :not_present], [:status, :not_member]]
  end

  it "should not create a new Host with missing hostname" do
    status = "up"
    host = Host.create(:status => status)
    host.valid?.should == false
    host.errors.should == [[:name, :not_present]]
  end

  it "should not create a new Host with an invalid status" do
    hostname = "host3.domain.com"
    status = "online"
    host = Host.create(:name => hostname, :status => status)
    host.valid?.should == false
    host.errors.should == [[:status, :not_member]]
  end

  it "should not create a duplicate Host" do
    hostname = "host1.domain.com"
    status = "up"
    host1 = Host.create(:name => hostname, :status => status)
    host1.save
    host2 = Host.create(:name => hostname, :status => status)
    host2.valid?.should == false
    host2.errors.should == [[:name, :not_unique]]
  end

  it "should return all Hosts" do
    hostname1 = "host1.domain.com"
    status1 = "up"
    hostname2 = "host2.domain.com"
    status2= "down"
    host1 = Host.create(:name => hostname1, :status => status1)
    host2 = Host.create(:name => hostname2, :status => status2)
    host1.save
    host2.save
    Hosts.all.class.should == Array
    Hosts.all.size.should == 2
    Hosts.all.first.name.should == hostname1
    Hosts.all.first.status.should == status1
    Hosts.all.last.name.should == hostname2
    Hosts.all.last.status.should == status2
  end

end
