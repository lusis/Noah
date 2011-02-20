# Brain dump of stuff
* Documentation

    Need to finish documenting everything for YARD to pick up.

* Namespace models

   This is proving to be more of a headache than I though. In the interim, I'm going to prepend models with Noah (i.e. `Host` becomes `NoahHost`)

* Stabilize API

    I'm seriously considering moving to a single endpoint with JSON request bodies. Still up in the air. I'm not totally sold on the current layout.

* Write my own CLI class

    I think I might be bumping into some issues related to Vegas as well.

* Watchers

    This is going to be a fun task. I'm serious.

* Ephemeral nodes

    Not sure how I want to implement that. Not too keen on storing them as in-memory hashes. Maybe a LRU in Redis?

* Examples

    I need to make some example apps to really demonstrate what I'm trying to accomplish. 

* Clean up deps

    Feels like I'm relying too much on external libraries.

* Benchmark

    Need some client libs for this

# Done TODOS
* Github pages
  - see [[http://lusis.github.com/Noah/]]

* Bundle a war
  - see [[https://github.com/downloads/lusis/Noah/noah.war]]

* Examples
  - Sort of done. Demo app is up! [[http://noah-demo.heroku.com/]]

* Consider ditching Sinatra::Namespace
  - Done. It was also causing issues with YARD generation. @rkh confirmed known issue via twitter.

## Watcher specific stuff
* Implement a watcher client
* Implement a watcher endpoint
* Implement webhooks
* Implement AMQP
* Implement REST
* Implement JMX on JRuby
