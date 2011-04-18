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
  sample_data = File.expand_path(File.join("..", "spec", "support","sample_data.rb"),__FILE__)
  instance_eval(File.open(sample_data).read)
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
