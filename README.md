# Noah testing quickstart
(make sure redis is running)

## Setup
Edit setup.rb and config/db.rb if you want to point to a different db on your local redis install

_ruby setup.rb_

	Creating Host entry for 'localhost'
	Create Service entry for redis
	Create Service entry for noah
	Creating Application entry for 'noah'
	Creating Configuration entry for 'noah'
	Setup successful!

## Run it
_rackup config.ru_

	[2011-01-17 08:00:30] INFO  WEBrick 1.3.1
	[2011-01-17 08:00:30] INFO  ruby 1.9.2 (2010-12-25) [x86_64-linux]
	[2011-01-17 08:00:30] INFO  WEBrick::HTTPServer#start: pid=15349 port=9292

## Example links
[Noah Start Page](http://localhost:9292/)

If you have Noah running, you can hit the above link for some links created by the setup samples.

## All configs
_curl http://localhost:9292/c/_

	[
	 {"id":"1",
	  "name":"db",
	  "format":"string",
	  "body":"redis://127.0.0.1:6379/0",
	  "update_at":"2011-01-17 14:12:43 UTC",
	  "application":"noah"
	 }
	]

## All services
_curl http://localhost:9292/s/_

	[
	 {
	  "id":"1",
	  "name":"redis",
	  "state":true,
	  "updated_at":"2011-01-17 14:12:43 UTC",
	  "host":"localhost"
	 },
	 {
	  "id":"2",
	  "name":"noah",
	  "state":true,
	  "updated_at":"2011-01-17 14:12:43 UTC",
	  "host":"localhost"
	 }
	]

## All hosts
_curl http://localhost:9292/h/_

	[
	 {
	  "id":"1",
	  "name":"localhost",
	  "state":true,
	  "updated_at":"2011-01-17 14:12:43 UTC",
	  "services":[
		      {
		       "id":"1",
		       "name":"redis",
		       "state":true,
		       "updated_at":"2011-01-17 14:12:43 UTC",
		       "host":"localhost"
		      },
		      {
		       "id":"2",
		       "name":"noah",
		       "state":true,
		       "updated_at":"2011-01-17 14:12:43 UTC",
		       "host":"localhost"
		      }
		     ]
	 }
	]

## All applications
_curl http://localhost:9292/a/_

	[
	 {
	  "id":"1",
	  "name":"noah",
	  "updated_at":"2011-01-17 14:12:43 UTC"
	 }
	]

Most other combinations of endpoints work as well:

* `http://localhost:9292/h/<hostname>/s/` - All service for `<hostname>`
* `http://localhost:9292/h/<hostname>/s/<servicename>` - `<servicename>` on `<hostname>`
* `http://localhost:9292/a/<appname>/<configname>` - Configuration for `<appname>`
* `http://localhost:9292/c/<appname>/<element>` - Specific configuration element for `<appname>`

	{
	 "id":"1",
	 "name":"db",
	 "format":"string",
	 "body":"redis://127.0.0.1:6379/0",
	 "update_at":"2011-01-17 14:12:43 UTC",
	 "application":"noah"
	}

# Adding new entries
I've not yet flushed out the put support for each route yet. I've been doing additions via `irb` for now:

## Adding a new application and configuration item

	irb -r ./irbstub.rb

	a1 = Application.create(:name => 'myapplication')
	if a1.save
	  a1.configurations << Configuration.create(:name => 'jsonconfigobj', :format => 'json', :body => '{"configvar1":"foo","configvar2":"bar"}', :application => a1)
	end
	JSON.parse(Configuration[2].body)

	{"configvar1"=>"foo", "configvar2"=>"bar"}

## database.yml inside Noah? Sure!

	dbyaml = <<EOY
	development:
	  adapter: mysql
	  database: rails_development
	  username: root
	  password: my super secret password
	EOY
	a2 = Application.create(:name => 'myrailsapp')
	if a2.save
	  a2.configurations << Configuration.create(:name => 'database.yml', :format => 'yaml', :body => dbyaml, :application => a2)
	end
	puts YAML.dump(Configuration[3].body)

	development:
	  adapter: mysql
	  database: rails_development
	  username: root
	  password: my super secret password

# Hosts and Services/Applications and Configurations
I'm still noodling out some things around Hosts and Services. There's a field called `state` that's a Boolean. The thought is that `state` set at `0` or `false` means that service or Host is unavailable. Services would, when they start up, send a put to Noah setting the flag to online. There's a bit of overlap between Applications and Services but I think the distinction is clear. Applications have configurations and Hosts have Services.

# Constraints
You can view all the constraints inside `models.rb` but here they are for now:

* A new host must have at least `name` and `state` set.
* A new service must have at least `name` and `state` set.
* Each Host `name` must be unique
* Each Service `name` per Host must be unique
* Each Application `name` must exist and be unique
* Each Configuration name per Application must be unique.
* Each Configuration must have `name`,`format` and `body`

