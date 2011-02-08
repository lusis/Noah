# Brain dump of stuff
* Stabilize API
    I'm seriously considering moving to a single endpoint with JSON request bodies. Still up in the air. I'm not totally sold on the current layout.
* Consider ditching Sinatra::Namespace
    I spent most of the effort around namespacing my stuff in what appears to be trying to work around sinatra-namespace. Need to do a test refactor. Also Ohm doesn't appear to play nice with namespaced models.
* Write my own CLI class
    I think I might be bumping into some issues related to Vegas as well.
* Bundle a war
    Need to get a working and deployable war file (including self-executing)
* Watchers
    This is going to be a fun task. I'm serious.
* Ephemeral nodes
    Not sure how I want to implement that. Not too keen on storing them as in-memory hashes. Maybe a LRU in Redis?
* Examples
    I need to make some example apps to really demonstrate what I'm trying to accomplish. 
* Github pages
    @pengwynn won't love me if I don't ;)
* Clean up deps
    Feels like I'm relying too much on external libraries.
* Benchmark
    Need some client libs for this

## Watcher specific stuff
* Implement a watcher client
* Implement a watcher endpoint
* Implement webhooks
* Implement AMQP
* Implement REST
* Implement JMX on JRuby
