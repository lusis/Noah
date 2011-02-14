# Examples
These are some notes regarding the following examples

## websocket.rb
This is an example of using Websockets, EventMachine and Redis PubSub to provide a "status" console of sorts.

### Requirements

You'll need to grab a few additional gems

* (em-hiredis)[https://github.com/mloughran/em-hiredis]
 You'll have to compile/install from source. Sorry. Should pull in the `hiredis` native ext.
* (em-websocket)[https://github.com/igrigorik/em-websocket]
 Available via rubygems

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
