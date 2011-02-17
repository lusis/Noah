# Examples
The following is a list of notes regarding the examples in this directory.

## General Requirements

You'll need a few additional gems

* [em-hiredis](https://github.com/mloughran/em-hiredis)
 You'll have to compile/install from source. Sorry. Should pull in the `hiredis` native ext.
* [em-http-request](https://github.com/igrigorik/em-http-request)
 Available via rubygems
* [em-websocket](https://github.com/igrigorik/em-websocket)
 Available via rubygems

## custom-watcher.rb
This is an idea I'm tossing around for allowing easy custom watchers to be written.
Essentially the idea is that you tap into the Redis subscription with a defined pattern and a destination.

### Example

	require './watcher-idea.rb'

	Noah::Watcher.watch do
	  pattern "noah.Configuration"
	  destination Proc.new {|x| something_with(x)}
	  run!
	end

## logger.rb
An example using logger as a watcher. Pretty straighforward.


## httpclient.rb/httpclient-server.rb
This is an example of how the Webhook system would work

### Running

To get the maximum effect, start with a clean Redis database

* Start the webhook reciever

	noah/examples$ ruby httpclient-server.rb 
	== Sinatra/1.1.2 has taken the stage on 4567 for development with backup from Thin
	>> Thin web server (v1.2.7 codename No Hup)
	>> Maximum connections set to 1024
	>> Listening on 0.0.0.0:4567, CTRL+C to stop

* Start the webhook publisher

	noah/examples$ ruby httpclient.rb

* Run the rake sample script

In the publisher window, you should see some messages like so:

	Got message for noah.Host[localhost].create
	Got message for noah.Host[localhost].save
	Got message for noah.Host[localhost].save
	Got message for noah.Host[localhost].update

In the server window, you should see the following:

	"{\"id\":\"1\",\"name\":\"localhost\",\"status\":\"up\",\"created_at\":\"2011-02-15 05:19:05 UTC\",\"updated_at\":\"2011-02-15 05:19:05 UTC\",\"services\":[]}"
	127.0.0.1 - - [15/Feb/2011 00:19:05] "POST /webhook HTTP/1.1" 200 135 0.0024
	"{\"id\":\"1\",\"name\":\"localhost\",\"status\":\"up\",\"created_at\":\"2011-02-15 05:19:05 UTC\",\"updated_at\":\"2011-02-15 05:19:05 UTC\",\"services\":[]}"
	127.0.0.1 - - [15/Feb/2011 00:19:05] "POST /webhook HTTP/1.1" 200 135 0.0004
	"{\"id\":\"1\",\"name\":\"localhost\",\"status\":\"up\",\"created_at\":\"2011-02-15 05:19:05 UTC\",\"updated_at\":\"2011-02-15 05:19:05 UTC\",\"services\":[]}"


## websocket.rb
This is an example of using Websockets, EventMachine and Redis PubSub to provide a "status" console of sorts.

### Running

To get the maximum effect, start with a clean Redis database.

* Start the server:

	~/development/noah/examples$ ./websocket.rb 
	>> Thin web server (v1.2.7 codename No Hup)
	>> Maximum connections set to 1024
	>> Listening on 0.0.0.0:3000, CTRL+C to stop

You should be able to load up the "normal" Noah sample page on [http://localhost:3000].

* Load the "websocket" file

In another browser window, open the `websocket.html` file.

* Send a message

From another terminal window send the following:

	curl -X PUT -d '{"name":"testhost2","status":"down"}' http://localhost:3000/h/testhost2

You should see the message come across in the browser window like so:

	connected...

	2 connected and waiting....

	(noah.Host[testhost2].create) {"id":"1","name":"testhost2","status":"down","created_at":"2011-02-14 20:58:04 UTC","updated_at":"2011-02-14 20:58:04 UTC","services":[]}

	(noah.Host[testhost2].save) {"id":"1","name":"testhost2","status":"down","created_at":"2011-02-14 20:58:04 UTC","updated_at":"2011-02-14 20:58:04 UTC","services":[]}

	(noah.Host[testhost2].save) {"id":"1","name":"testhost2","status":"down","created_at":"2011-02-14 20:58:04 UTC","updated_at":"2011-02-14 20:58:04 UTC","services":[]}

	(noah.Host[testhost2].update) {"id":"1","name":"testhost2","status":"down","created_at":"2011-02-14 20:58:04 UTC","updated_at":"2011-02-14 20:58:04 UTC","services":[]}

You can see the Watcher pattern in the parenthesis and then the JSON message body.

For fun, refresh the page to clear it and then run the sample data population rake task.

### Known issues
When I started working on the Watcher stuff, I realized that I'm sending A LOT of extranous messages. These are mostly the result of the way I'm creating new objects with Ohm (i.e. via `.create`).
I'll be cleaning that up and trying to get down to a single message per operation.
