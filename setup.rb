require 'ohm'
require 'json'

require File.join(File.dirname(__FILE__), 'config/db')
require File.join(File.dirname(__FILE__), 'models')

# Add an entry for my localhost
puts "Creating Host entry for 'localhost'"
h = Host.create(:name => 'localhost', :state => 1)
if h.save
  %w[redis noah].each do |service|
    puts "Create Service entry for #{service}"
    s = Service.create(:name => service, :state => 1, :host => h)
    h.services << s
  end
end

puts "Creating Application entry for 'noah'"
a = Application.create(:name => 'noah')
if a.save
  puts "Creating Configuration entry for 'noah'"
  c = Configuration.create(:name => 'db', :format => 'string', :body => 'redis://127.0.0.1:6379/0', :application => a)
  a.configurations << c
end

puts "Setup successful!"
