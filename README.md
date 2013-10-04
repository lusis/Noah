(_please read [here](http://goo.gl/pJvMw) before continuing_)

# Noah
_"look at this effing rainbow I just made for you"_

Noah is an application registry inspired by [Apache ZooKeeper](http://zookeeper.apache.org)

What does that mean? From the ZooKeeper Home Page:

> ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. All of these kinds of services are used in some form or another by distributed applications.

Essentially Noah is a port of parts of that functionality into a stateless RESTish application.

## Some background
It's probably worth reading the following blog posts before going any further to clear up any possible misunderstandings.
Noah is not a direct replacement for ZK. It's a conceptual port. More than anything, it was an itch I needed to scratch:

- [On Noah - Part 1](http://blog.lusis.org/blog/2011/05/16/on-noah-part-1/)
- [On Noah - Part 2](http://blog.lusis.org/blog/2011/05/17/on-noah-part-2/)
- [On Noah - Part 3](http://blog.lusis.org/blog/2011/05/18/on-noah-part-3/)
- [On Noah - Part 4](http://blog.lusis.org/blog/2011/05/19/on-noah-part-4/)

Also the following post was where I sort of discussed it early on:

- [Ad-hoc configuration and Coordination](http://lusislog.blogspot.com/2011/03/ad-hoc-configuration-coordination-and.html)

## Things Noah does not do

- Paxos, ZAB or any other sort of consensus protocol
- Noah itself is not distributed (yet).
- ACLs (yet)
- Leader election of any kind

## Things Noah can do
_note that these terms are fairly overloaded depending on who you talk to_

- Service registry
- Node registry
- Configuration Registry
- Group Services
- Watches (albeit differently)


## Quick Start
The quickstart guide has been moved to the wiki:

[Quick Start Guide](https://github.com/lusis/Noah/wiki/Quick-Start)

## Design Goals
Noah has a few basic design goals:

* The system **MUST** support RESTful interaction for operations where REST maps properly
* The system **MUST** support basic concepts of hosts, services, applications and configurations
* The system **MUST** support horizontal scaling.

Additionally:

* The system **SHOULD** be flexible in deployment options.
* The system **SHOULD** support watches similar to ZooKeeper
* The system **SHOULD** support pluggable callbacks for watches.
* The system **SHOULD** support being a client of itself.

## Opinionated Stack
Noah is somewhat opinionated in its stack. Noah attempts to minimize the external requirements wherever possible to allow for the widest possible installation options.
However, excellent work has been done to create performant and well-tested libraries that would be foolish to ignore. To this end, the current requirements are:

* [Redis 2.0](http://redis.io)
* [Sinatra](http://www.sinatrarb.com)
* [Ohm/Ohm-Contrib](http://ohm.keyvalue.org)
* [EventMachine](http://rubyeventmachine.com)

The above stack provides much of the functionality needed to port over ZooKeeper concepts.

### Redis
Redis is the backbone of the system. Through the native [datatypes](http://redis.io/commands) and [pubsub](http://redis.io/commands#pubsub) capabilities, much of the heavy lifting has already been done.

### Sinatra
Sinatra is the perfect library for creating API-only style applications. It allows you do focus on the meat of what an endpoint should do instead of the hassle of creating the endpoint.

### Ohm
Ohm is quite simply the most unobtrusive and flexible orm for Redis. It gets out of the way and allows you to very easily interact directly with Redis if the need arises

### EventMachine
EventMachine combined with Redis pubsub forms the basis of the Watcher and callback system.

## Motivation
It's something I've wanted to do for a while. Everytime I've needed something like Zookeeper, Zookeeper has always been too bulky and had too many moving parts. I've also always needed to interact with it from more than just Java or C. Sometimes it's been Ruby and sometimes it's been Python.

In the end, we reinvent the wheel ANYWAY. Maybe we do something like have our CM tool write our application config files with a list of memcached hosts. Maybe we write our own logic around (shudder) RMI to do some chatty broadcasting around the network for finding local nodes of type X. We always reinvent the wheel in some way.

## More information
Here are a list of some key [wiki](https://github.com/lusis/Noah/wiki) pages:

* [Concepts](https://github.com/lusis/Noah/wiki/Concepts)
    How Noah views various object types in the system
* [API](https://github.com/lusis/Noah/wiki/Stablize-API)
    The API is currently in draft state. It will be finalized before the 1.0 release.
* [Example Use Cases](https://github.com/lusis/Noah/wiki/Example-Use-Cases)
    Some use cases for Noah and how it would fit into an existing application or infrastructure
* [Watchers and Callbacks](https://github.com/lusis/Noah/wiki/Watchers-and-Callbacks)
    The general idea behind how Noah would implement watches
* [Watcher/Callback Examples](https://github.com/lusis/Noah/blob/master/examples/README.md)
    Some example callbacks.
