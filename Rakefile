$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "lib")))
require 'bundler'
require 'rspec/core'
require 'rspec/core/rake_task'

REDIS_DIR = File.expand_path(File.join("..", "spec", "support"), __FILE__)
REDIS_CNF = File.join(REDIS_DIR, "test-redis.conf")

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end


task :default => :run
task :test => :run

desc "Run tests and manage server start/stop"
task :run => [:start, :spec, :stop]

task :start do
  puts "Starting redis-server"
  system "redis-server #{REDIS_CNF}"
end

task :stop do
  puts "Killing redis"
  system "killall -TERM redis-server"
end

namespace :coverage do
  task(:clean) { rm_f "coverage.data" }
end
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.rcov = true
  t.verbose = true
  t.rcov_opts = %q[--aggregate coverage.data --sort coverage --text-report --exclude "config,.bundle/*,gems/*,spec/*" -o doc/coverage -Ilib -i "noah.rb"]
end

desc "Populate database with sample dataset"
task :sample, :redis_url do |t, args|
  require 'noah'

  Ohm::connect(:url => args.redis_url)
  Ohm::redis.flushdb 
  puts "Creating watchers..."
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
      s = Noah::Service.create(:name => service, :status => "up", :host => h)
      h.services << s
    end
  end

  puts "Creating Application entry for 'noah'"
  a = Noah::Application.create(:name => 'noah')
  if a.save
    puts "Creating Configuration entry for 'noah'"
    cr = Noah::Configuration.create(:name => 'redis', :format => 'string', :body => 'redis://127.0.0.1:6379/0', :application => a)
    ch = Noah::Configuration.create(:name => 'host', :format => 'string', :body => 'localhost', :application  => a)
    cp = Noah::Configuration.create(:name => 'port', :format => 'string', :body => '9292', :application => a)
    %w[cr ch cp].each do |c|
      a.configurations << eval(c)
    end
  end

  puts "Creating sample entries - Host and Service"
  %w[host1.domain.com host2.domain.com host3.domain.com].each do |host|
    h = Noah::Host.create(:name => host, :status => "up")
    if h.save
      %w[http https smtp mysql].each do |service|
        s = Noah::Service.create(:name => service, :status => "pending", :host => h)
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
    c1 = Noah::Configuration.create(:name => 'database.yml', :format => 'yaml', :body => my_yaml, :application => a1)
    a1.configurations << c1
  end

  a2 = Noah::Application.create(:name => 'myrestapp1')
  if a2.save
    c2 = Noah::Configuration.create(:name => 'config.json', :format => 'json', :body => my_json, :application => a2)
    a2.configurations << c2
  end
  puts "Sample data populated!"
end

begin
  require 'yard'
  require 'yard/sinatra'
  desc "Generate documentation"
  YARD::Rake::YardocTask.new do |t|
    t.files   = ['lib/**/*.rb']   # optional
    t.options = ['--title', "Noah #{Noah::VERSION} Documentation"]
    t.options += ['--plugin', "yard-sinatra"]
    t.options += ['--protected', '--private'] # optional
  end
rescue LoadError
  "You need YARD installed to generate docs"
end

task :start_demo do
  puts "Soon, young padawan"
end

desc "Start an irb session with all libraries loaded"
task :shell do
  sh "irb -r./lib/noah.rb"
end
