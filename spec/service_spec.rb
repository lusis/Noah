require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Service", :reset_redis => true do

  it "should create a new Service" do
    servicename = "myservice"
    servicestatus = "up"
    hostname = "mytesthost1"
    hoststatus = "up"
    host = Host.create(:name => hostname, :status => hoststatus)
    host.save
    service = Service.create(:name => servicename, :status => servicestatus, :host => host)
    service.valid?.should == true
    service.save
    service.name.should == servicename
    service.status.should == servicestatus
    service.host_id.should == host.id
    host.services[1].name.should == servicename
  end  

  it "should not create a new Service when missing a Host" do
    servicename = "myservice1"
    servicestatus = "up"
    service = Service.create(:name => servicename, :status => servicestatus)
    service.valid?.should == false
    service.errors.should == [[:host_id, :not_present]]
  end

  it "should not create a new Service when missing a name" do
    host = Host.create(:name => "host1.domain.com", :status => "up")
    host.save
    service = Service.create(:status => "up", :host => host)
    service.valid?.should == false
    service.errors.should == [[:name, :not_present]]
  end

  it "should not create a new Service when missing a status" do
    host = Host.create(:name => "host1.domain.com", :status => "up")
    host.save
    service = Service.create(:name => 'foo', :host => host)
    service.valid?.should == false
    service.errors.should == [[:status, :not_present], [:status, :not_member]]
  end

  it "should not create a new Service with an invalid status" do
    host = Host.create(:name => "host1.domain.com", :status => "up")
    host.save
    service = Service.create(:name => "myservice", :status => "invalid_status", :host => host)
    service.valid?.should == false
    service.errors.should == [[:status, :not_member]]
  end

  it "should not create a duplicate Service" do
    host = Host.create(:name => "host1.domain.com", :status => "up")
    host.save
    s = Service.create(:name => "myservice", :status => "up", :host => host)
    s.save
    s1 = Service.create(:name => "myservice", :status => "up", :host => host)
    s1.valid?.should == false
    s1.errors.should == [[[:name, :host_id], :not_unique]]
  end

  it "should create a new Service with find_or_create" do
    host = Host.create(:name => "h1", :status => "up")
    host.save
    service = Service.find_or_create(:name => "s1", :status => "up", :host => host)
    service.save
    service.is_new?.should == true
  end

  it "should update an existing Service with find_or_create" do
    host = Host.create(:name => "h2", :status => "up")
    host.save
    service = Service.find_or_create(:name => "s2", :status => "up", :host => host)
    service.save
    sleep 1
    service2 = Service.find_or_create(:name => "s2", :status => "up", :host => host)
    service2.save
    service2.is_new?.should == false
  end

  it "should delete a Service" do
    h = Host.create(:name => "h1", :status => "up")
    h.save
    s = Service.create(:name => "s1", :status => "up", :host => h)
    s.save
    s = Service.find(:name => "s1").first
    s.delete
    s = Service.find(:name => "s1").first
    s.should == nil
  end

  it "should find multiple Services" do
    h = Host.create(:name => "h1", :status => "up")
    if h.valid?
      h.services << Service.create(:name => "s1", :status => "up", :host => h)
      h.services << Service.create(:name => "s2", :status => "up", :host => h)
      h.save
    end
    Services.all.size.should == 2
    Services.all.first.name.should == "s1"
    Services.all.last.name.should == "s2"
  end  
end
