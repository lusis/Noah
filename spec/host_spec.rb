require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Using the Host Model", :reset_redis => true do

  describe "should" do
    it "create a new Host with no services" do
      hostname = "host1.domain.com"
      hoststatus = "up"
      host = Noah::Host.create(:name => hostname, :status => hoststatus)
      host.valid?.should == true
      host.save
      host.name.should == hostname
      host.status.should == hoststatus
      host.services.size.should == 0
    end

    it "create a new Host with services" do
      hostname = "host2.domain.com"
      hoststatus = "down"
      servicename = 'myservice'
      servicestatus = 'pending'
      host = Noah::Host.create(:name => hostname, :status => hoststatus)
      host.valid?.should == true
      host.save
      host.services << Noah::Service.create(:name => servicename, :status => servicestatus, :host => host)
      host.name.should == hostname
      host.status.should == hoststatus
      host.services.size.should == 1
      host.services.first.valid?.should == true
      host.services.first.name.should == servicename
      host.services.first.status.should == servicestatus
      host.services.first.host_id.should == host.id
    end

    it "create a Host via find_or_create" do
      hostname = "host3.domain.com"
      hoststatus = "up"
      host = Noah::Host.find_or_create(:name => hostname, :status => hoststatus)
      host.valid?.should == true
      host.save
      host.is_new?.should == true
    end

    it "update a Host via find_or_create" do
      hostname = "host3.domain.com"
      hoststatus = "pending"
      newstatus = "down"
      host = Noah::Host.find_or_create(:name => hostname, :status => hoststatus)
      host.valid?.should == true
      host.save
      host.is_new?.should == true
      sleep 1
      host1 = Noah::Host.find_or_create(:name => hostname, :status => newstatus)
      host1.save
      host1.is_new?.should == false
    end

    it "delete a Host" do
      hostname = "host3.domain.com"
      hoststatus = "pending"
      host = Noah::Host.create(:name => hostname, :status => hoststatus)
      host.save
      host.delete
      Noah::Host.find(:name => hostname).empty?.should == true
    end  

    it "should return all Hosts" do
      hostname1 = "host1.domain.com"
      status1 = "up"
      hostname2 = "host2.domain.com"
      status2= "down"
      host1 = Noah::Host.create(:name => hostname1, :status => status1)
      host2 = Noah::Host.create(:name => hostname2, :status => status2)
      host1.save
      host2.save
      Noah::Hosts.all.class.should == Hash
      Noah::Hosts.all.size.should == 2
      Noah::Hosts.all.has_key?(hostname1).should == true
      Noah::Hosts.all[hostname1][:status].should == status1
      Noah::Hosts.all.has_key?(hostname2).should == true
      Noah::Hosts.all[hostname2][:status].should == status2
    end
  end

  describe "should not" do
    it "create a new Host with missing status" do
      hostname ="host3.domain.com"
      host = Noah::Host.create(:name => hostname)
      host.valid?.should == false
      host.errors.should == [[:status, :not_present], [:status, :not_member]]
    end

    it "create a new Host with missing hostname" do
      status = "up"
      host = Noah::Host.create(:status => status)
      host.valid?.should == false
      host.errors.should == [[:name, :not_present]]
    end

    it "create a new Host with an invalid status" do
      hostname = "host3.domain.com"
      status = "online"
      host = Noah::Host.create(:name => hostname, :status => status)
      host.valid?.should == false
      host.errors.should == [[:status, :not_member]]
    end

    it "create a duplicate Host" do
      hostname = "host1.domain.com"
      status = "up"
      host1 = Noah::Host.create(:name => hostname, :status => status)
      host1.save
      host2 = Noah::Host.create(:name => hostname, :status => status)
      host2.valid?.should == false
      host2.errors.should == [[:name, :not_unique]]
    end
  end

end
