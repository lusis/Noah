require 'noah'

Ohm::redis.flushdb 
puts "Creating sample entries - Watchers"
Noah::Watcher.create :endpoint => "dummy://applications", :pattern => "//noah/applications"
Noah::Watcher.create :endpoint => "dummy://configurations", :pattern => "//noah/configurations"
Noah::Watcher.create :endpoint => "dummy://hosts", :pattern => "//noah/hosts"
Noah::Watcher.create :endpoint => "dummy://services", :pattern => "//noah/services"
Noah::Watcher.create :endpoint => "dummy://ephemerals", :pattern => "//noah/ephemerals"
puts "Creating Host entry for 'localhost'"
h = Noah::Host.create(:name => 'localhost', :status => "up")
if h.save
  %w[redis noah].each do |service|
    puts "Create Service entry for #{service}"
    s = Noah::Service.create(:name => service, :status => "up", :host_id => h.id)
  end
end

puts "Creating Application entry for 'noah'"
a = Noah::Application.create(:name => 'noah')
if a.save
  puts "Creating Configuration entry for 'noah'"
  cr = Noah::Configuration.create(:name => 'redis_url', :format => 'string', :body => 'redis://127.0.0.1:6379/0')
  ch = Noah::Configuration.create(:name => 'noah_host', :format => 'string', :body => 'localhost')
  cp = Noah::Configuration.create(:name => 'noah_port', :format => 'string', :body => '9292')
  [cr,ch,cp].each do |c|
    a.configurations << c
  end
end

puts "Creating sample entries - Host and Service"
%w[host1.domain.com host2.domain.com host3.domain.com].each do |host|
  h = Noah::Host.create(:name => host, :status => "up")
  if h.save
    %w[http https smtp mysql].each do |service|
      s = Noah::Service.create(:name => service, :status => "pending", :host_id => h.id)
      h.services << s
    end
  end
end

puts "Creating sample entries - Application and Configuration"
my_yaml = <<EOY
development:
  database: development_database
  adapter: mysql
  username: dev_user
  password: dev_password
EOY
my_json = <<EOJ
{
  "id":"hostname",
  "data":"localhost"
}
EOJ

a1 = Noah::Application.create(:name => 'myrailsapp1')
if a1.save
  c1 = Noah::Configuration.create(:name => 'database.yml', :format => 'yaml', :body => my_yaml)
  a1.configurations << c1
end

a2 = Noah::Application.create(:name => 'myrestapp1')
if a2.save
  c2 = Noah::Configuration.create(:name => 'config.json', :format => 'json', :body => my_json)
  a2.configurations << c2
end

puts "Creating sample entries - Ephemerals"
e1 = Noah::Ephemeral.create(:path => '/some/random/path/item1', :data => 'some_data')
e2 = Noah::Ephemeral.create(:path => '/some/random/path/', :data => '{"children":["item1", "item2"]}')

puts "Creating sample entries - Links and Tags"
l1 = Noah::Link.new
l1.path = "/my_sample_organization"
l1.save
l1.nodes = [a1, c2, Noah::Host.find(:name => 'localhost').first, Noah::Service.find(:name => 'redis').first, e1, e2]
a1.tag! ["production", "sample_data"]
e2.tag! ["ephemeral", "development"]
c1.tag! "development"
Noah::Service.all.first.tag! ["development", "out-of-service"]
Noah::Service.all.first.link! "/my_sample_organization"


puts "Sample data populated!"

