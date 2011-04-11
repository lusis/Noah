require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Noah Service Model", :reset_redis => true do
  describe "should" do

    it "create a new Service" do
      servicename = "myservice"
      servicestatus = "up"
      hostname = "mytesthost1"
      hoststatus = "up"
      host = Noah::Host.create(:name => hostname, :status => hoststatus)
      host.save
      service = Noah::Service.create(:name => servicename, :status => servicestatus, :host => host)
      service.valid?.should == true
      service.save
      service.name.should == servicename
      service.status.should == servicestatus
      service.host_id.should == host.id
      host.services[1].name.should == servicename
    end

    it "create a new Service with find_or_create" do
      host = Noah::Host.create(:name => "h1", :status => "up")
      host.save
      service = Noah::Service.find_or_create(:name => "s1", :status => "up", :host => host)
      service.save
      service.is_new?.should == true
    end

    it "update an existing Service with find_or_create" do
      host = Noah::Host.create(:name => "h2", :status => "up")
      host.save
      service = Noah::Service.find_or_create(:name => "s2", :status => "up", :host => host)
      service.save
      sleep 1
      service2 = Noah::Service.find_or_create(:name => "s2", :status => "up", :host => host)
      service2.save
      service2.is_new?.should == false
    end

    it "delete a Service" do
      h = Noah::Host.create(:name => "h1", :status => "up")
      h.save
      s = Noah::Service.create(:name => "s1", :status => "up", :host => h)
      s.save
      s = Noah::Service.find(:name => "s1").first
      s.delete
      s = Noah::Service.find(:name => "s1").first
      s.should == nil
    end

    it "find multiple Services" do
      h = Noah::Host.create(:name => "h1", :status => "up")
      if h.valid?
        h.services << Noah::Service.create(:name => "s1", :status => "up", :host => h)
        h.services << Noah::Service.create(:name => "s2", :status => "up", :host => h)
        h.save
      end
      Noah::Services.all.size.should == 2
      Noah::Services.all.has_key?("s1").should == true
      Noah::Services.all.has_key?("s2").should == true
    end

  end

  describe "should not" do

    it "create a new Service when missing a Host" do
      servicename = "myservice1"
      servicestatus = "up"
      service = Noah::Service.create(:name => servicename, :status => servicestatus)
      service.valid?.should == false
      service.errors.should == [[:host_id, :not_present]]
    end

    it "create a new Service when missing a name" do
      host = Noah::Host.create(:name => "host1.domain.com", :status => "up")
      host.save
      service = Noah::Service.create(:status => "up", :host => host)
      service.valid?.should == false
      service.errors.should == [[:name, :not_present]]
    end

    it "create a new Service when missing a status" do
      host = Noah::Host.create(:name => "host1.domain.com", :status => "up")
      host.save
      service = Noah::Service.create(:name => 'foo', :host => host)
      service.valid?.should == false
      service.errors.should == [[:status, :not_present], [:status, :not_member]]
    end

    it "create a new Service with an invalid status" do
      host = Noah::Host.create(:name => "host1.domain.com", :status => "up")
      host.save
      service = Noah::Service.create(:name => "myservice", :status => "invalid_status", :host => host)
      service.valid?.should == false
      service.errors.should == [[:status, :not_member]]
    end

    it "create a duplicate Service" do
      host = Noah::Host.create(:name => "host1.domain.com", :status => "up")
      host.save
      s = Noah::Service.create(:name => "myservice", :status => "up", :host => host)
      s.save
      s1 = Noah::Service.create(:name => "myservice", :status => "up", :host => host)
      s1.valid?.should == false
      s1.errors.should == [[[:name, :host_id], :not_unique]]
    end

  end

end
