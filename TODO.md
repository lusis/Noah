# Brain dump of stuff
* Fix JRuby

    This is an ongoing issue for me. I can't rely on stuff that's MRI only.

* Break agent into separate gem

    Again so that the server gem can be as lean as possible

* Documentation

    Need to finish documenting everything for YARD to pick up.

* Stabilize API

    I'm seriously considering moving to a single endpoint with JSON request bodies. Still up in the air. I'm not totally sold on the current layout.

* Write my own CLI class

    I think I might be bumping into some issues related to Vegas as well.

* Watchers

    **IN PROGRESS**
    Need to resolve some issues around pathing for Configuration and Service nodes however watch registration and listing are up.    
    Need to address alternative watcher URIs. Webhook is the only one supported right now.

* Ephemeral nodes

    **IN PROGRESS**
    implement lifetime support

* Examples

    Pretty happy with the examples I have but I need more. Want some in other languages - Python, Java, whatever!

* Clean up deps

    Feels like I'm relying too much on external libraries.

* Benchmark

    Need some client libs for this

# Done TODOS
* Github pages
  - see [[http://lusis.github.com/Noah/]]

* Examples
  - Sort of done. Demo app is up! [[http://noah-demo.heroku.com/]]. Also see `examples` directory.

* Consider ditching Sinatra::Namespace
  - Done. It was also causing issues with YARD generation. @rkh confirmed known issue via twitter.

* Namespace models
  - Done.

* Watchers
  - Done. GET PUT DELETE are all available at the '/w/' endpoint now!


## Watcher specific stuff
* Implement AMQP
* Implement REST
* Implement JMX on JRuby
