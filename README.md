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


## All configs
curl http://localhost:9292/c/
## All services
curl http://localhost:9292/s/
## All hosts
curl http://localhost:9292/h/
## All applications
curl http://localhost:9292/a/
