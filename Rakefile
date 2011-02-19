require 'bundler'
require 'rspec/core'
require 'rspec/core/rake_task'

task :default => [:spec]
task :test => [:spec]

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

namespace :coverage do
  desc "Delete aggregate coverage data."
  task(:clean) { rm_f "coverage.data" }
end
desc "Run Rcov code coverage analysis"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.rcov = true
  t.verbose = true
  t.rcov_opts = %q[--aggregate coverage.data --sort coverage --text-report --exclude "config,.bundle/*,gems/*,spec/*" -o doc/coverage -Ilib -i "noah.rb"]
end

desc "Populate database with sample dataset"
task :sample, :redis_url do |t, args|
  require 'ohm'
  require 'json'
  require File.join(File.dirname(__FILE__), 'lib','noah')

  Ohm::connect(:url => args.redis_url)
  Ohm::redis.flushdb 
  puts "Creating Host entry for 'localhost'"
  h = Host.create(:name => 'localhost', :status => "up")
  if h.save
    %w[redis noah].each do |service|
      puts "Create Service entry for #{service}"
      s = Service.create(:name => service, :status => "up", :host => h)
      h.services << s
    end
  end

  puts "Creating Application entry for 'noah'"
  a = Application.create(:name => 'noah')
  if a.save
    puts "Creating Configuration entry for 'noah'"
    cr = Configuration.create(:name => 'redis', :format => 'string', :body => 'redis://127.0.0.1:6379/0', :application => a)
    ch = Configuration.create(:name => 'host', :format => 'string', :body => 'localhost', :application  => a)
    cp = Configuration.create(:name => 'port', :format => 'string', :body => '9292', :application => a)
    %w[cr ch cp].each do |c|
      a.configurations << eval(c)
    end
  end

  puts "Creating sample entries - Host and Service"
  %w[host1.domain.com host2.domain.com host3.domain.com].each do |host|
    h = Host.create(:name => host, :status => "up")
    if h.save
      %w[http https smtp mysql].each do |service|
        s = Service.create(:name => service, :status => "pending", :host => h)
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

  a1 = Application.create(:name => 'myrailsapp1')
  if a1.save
    c1 = Configuration.create(:name => 'database.yml', :format => 'yaml', :body => my_yaml, :application => a1)
    a1.configurations << c1
  end

  a2 = Application.create(:name => 'myrestapp1')
  if a2.save
    c2 = Configuration.create(:name => 'config.json', :format => 'json', :body => my_json, :application => a2)
    a2.configurations << c2
  end
  puts "Sample data populated!"
end
  
desc "Demo environment"
task :start_demo do
  puts "Soon, young padawan"
end
