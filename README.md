# Noah testing quickstart
(make sure redis is running)

## Setup
There is no specific configuration file in use anymore. Everything is configured via command-line options to the noah binary or stored in config.ru.

   * The instance of Redis is configured via the `REDIS_URL` env setting. This is honored by Ohm.
   * Redis DSN strings are in the format of "redis://hostname:port/db"
   * `RACK_ENV` is honored.
   * `rake sample["redis://localhost:6379/2"]` populates the locally running redis instance - db 2
   * `rake spec` runs the test suite (using 'redis://localhost:6379/3' for storing test data)

_rake sample_

	Creating Host entry for 'localhost'
	Create Service entry for redis
	Create Service entry for noah
	Creating Application entry for 'noah'
	Creating Configuration entry for 'noah'
	Creating sample entries - Host and Service
	Creating sample entries - Application and Configuration
	Setup successful!

## Run it
There are two way to run Noah

### config.ru
Edit config.ru to change the redis instance or rack environment.

### bin/noah
The binary script in bin was created using [Vegas](https://github.com/quirkey/vegas). It accepts the familiar rack options as well as an option for specifying the redis url.

	bin/noah -p 9292 -s thin -d -F -e production -r redis://localhost:6379/2
	[2011-02-07 16:48:15 -0500] Starting 'noah'...
	[2011-02-07 16:48:15 -0500] trying port 9292...
	Couldn't get a file descriptor referring to the console
	[2011-02-07 16:48:15 -0500] Running with Rack handler: Rack::Handler::Thin
	>> Thin web server (v1.2.7 codename No Hup)
	>> Maximum connections set to 1024
	>> Listening on 0.0.0.0:9292, CTRL+C to stop

If you leave off `-F`, all information will be logged to `$HOME/.vegas/noah`. Run `bin/noah -h` for more options.

Please note on JRuby that the port setting does not work for some f'cking reason. Bug claims to have been fixed. Until then, when on Jruby run like so:

  noah -F -d -r redis://localhost:6379/0

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
	  "status":"up",
	  "updated_at":"2011-01-17 14:12:43 UTC",
	  "host":"localhost"
	 },
	 {
	  "id":"2",
	  "name":"noah",
	  "status":"up",
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
	  "status":"up",
	  "updated_at":"2011-01-17 14:12:43 UTC",
	  "services":[
		      {
		       "id":"1",
		       "name":"redis",
		       "status":"up",
		       "updated_at":"2011-01-17 14:12:43 UTC",
		       "host":"localhost"
		      },
		      {
		       "id":"2",
		       "name":"noah",
		       "status":"up",
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

* `http://localhost:9292/h/<hostname>/<servicename>` - `<servicename>` on `<hostname>`
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
There are two ways to add new objects: via irb and via the [API](https://github.com/lusis/Noah/wiki/Stabilize-API) on a running instance. The API is still in a state of flux.

## Adding a new application and configuration item

	irb -rohm -rohm/contrib -r./lib/noah/models.rb

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
Host/Services and Applications/Configurations are almost the same thing with a few exceptions. Here are some basic facts:

* Hosts have many Services
* Applications have many Configurations
* Hosts and Services have a status - `up`,`down` or `pending`

The intention of the `status` field for Hosts and Services is that a service might, when starting up, set the appropriate status. Same goes for said service shutting down. This also applies to hosts (i.e. a curl PUT is sent to Noah during the boot process).
 
While an application might have different "configurations" based on environment (production, qa, dev), the Configuration object in Noah is intended to be more holistic i.e. these are the Configuration atoms (a yaml file, property X, property Y) that form the running configuration of an Application.

Here's a holistic example using a tomcat application:

* Host running tomcat comes up. It sets its status as "pending"
* Each service on the box starts up and sets its status to "pending" and finally "up" (think steps in the init script for the service)
* Tomcat (now in the role of `Application`) given a single property in a properties file called "bootstrap.url", grabs a list of `Configuration`atoms it needs to run. Let's say, by default, Tomcat starts up with all webapps disabled. Using the `Configuration` item `webapps`, it knows which ones to start up.
* Each webapp (an application under a different context root) now has the role of `Application` and the role of `Service`. As an application, the webapp would grab things that would normally be stored in a .properties file. Maybe even the log4j.xml file. In the role of `Service`, a given webapp might be an API endpoint and so it would have a hostname (a virtual host maybe?) and services associated with it. Each of those, has a `status`.

That might be confusing and it's a fairly overly-contrived example. A more comon use case would be the above where, instead of storing the database.yml on the server, the Rails application actually reads the file from Noah. Now that might not be too exciting but try this example:

* Rails application with memcached as part of the stack.
* Instead of a local configuration file, the list of memcached servers is a `Configuration` object belonging to the rails application's `Application` object.
* As new memcached servers are brought online, your CM tool (puppet or chef) updates Noah
* Your Rails application either via restarting (and thus rebootstrapping the list of memcached servers from Noah) or using the Watcher subsystem is instantly aware of those servers. You could fairly easily implement a custom Watcher that, when the list of memcached server changes, the Passenger restart file is written.

Make sense?

# Constraints
You can view all the constraints inside `models.rb` but here they are for now:

* A new host must have at least `name` and `status` set.
* A new service must have at least `name` and `status` set.
* Each Host `name` must be unique
* Each Service `name` per Host must be unique
* Each Application `name` must exist and be unique
* Each Configuration name per Application must be unique.
* Each Configuration must have `name`,`format` and `body`

