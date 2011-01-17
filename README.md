_(looking for the real code? See the section "Where's the code?")_

# Noah
Noah is a lightweight registry based on the concepts in the Apache Zookeeper project.

## Impetus
Apache Zookeeper is an amazing peice of software. From the project's own description:

> ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. All of these kinds of services are used in some form or another by distributed applications.

The problem is that zookeeper is *BIG*. It has quite a bit of overhead associated with it and it's not easily accessible from anything other than C or Java. You could argue that you need to be big when this service is the crux of your infrastructure but that's confusing big with highly available and highly scalable.

_(yes I'm aware that you can run Zookeeper in single server mode from a single JAR file)_

## So why reinvent the wheel?
It's something I've wanted to do for a while. Everytime I've needed something like Zookeeper, Zookeeper has always been too bulky and had too many moving parts. I've also always needed to interact with it from more than just Java or C. Sometimes it's been Ruby and sometimes it's been Python.

In the end, we reinvent the wheel ANYWAY. Maybe we do something like have our CM tool write our application config files with a list of memcached hosts. Maybe we write our own logic around (shudder) RMI to do some chatty broadcasting around the network for finding local nodes of type X. We always reinvent the wheel in some way.

## Design Goals
I have a few basic design goals:
- The system must support RESTful interaction for operations where REST maps properly
- The system must support basic concepts of hosts, services and configuration parameters
- The system must support horizontal scaling
- The system must support traditional load balancing methodologies
- The system must support ephemeral clients and stateless operation where applicable

In essence, the system must be resemble your typical web application.
Here are some "would really like to have" things:
- The system should support watches similar to ZooKeeper
- The system should support pluggable callback methods (more below)
- The system should support being a client of itself

## Opinionated stack
I've found that being opinionated has its benefits. Swappable storage backends are nice but those have to evolve naturally over time. To this end I've tried to keep the stack as lightweight and easy to distribute as possible. I'm also a big fan of the Unix philosophy of doing one thing and doing it very well. To this end, I've chosen the followng initial stack:
- Ruby
- EventMachine/Sinatra/Ohm
- Redis
The main reason for choosing Redis is that much of the functionality I need/that I want to implement from ZooKeeper is already available in Redis semantics. Essentially Noah becomes a custom API for Redis - a way to provide disconnected client operations for it. By using Ohm, I get an easy and unobtrusive orm that only does what I tell it to do. Sinatra was originally going to be the only inteface but as I thought about how best to handle the Watch scenario and callbacks, I realized I needed something a bit more evented - hence EventMachine.

## Pretty pictures
This is the original Mindmap I did when thinking about Noah. It's not complete and was just a dump of what was in my head at the time:

[Noah MindMap](https://github.com/lusis/Noah/raw/master/doc/noah-mindmap-original.png)

## Where's the code?
I'm still working on the codebase in a private local branch. Sorry. I'm going to be flailing around a bit trying a few things and don't want people to fork yet. I'll still commit regularly to that branch so you'll see said flailing in the history when I merge. What I've done is create a simple sinatra app that you can get a feel for where I'm headed with this. It's under the branch called "testing".
