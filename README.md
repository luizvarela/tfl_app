# TFL - Transport for London App

This application shows the traffic disruptions from a XML feed retrivied on https://api-portal.tfl.gov.uk/docs

Versions used

```
Rails 5.1.2
Ruby 2.4.0
```
# Dependencies

- Yarn (https://yarnpkg.com/lang/en/docs/install/)
- Redis

# Installation

```
git clone https://github.com/luizvarela/tfl_app.git
cd tfl_app
./bin/setup
mv .env.local .env
yarn
./bin/webpack-dev-server --hot --host 127.0.0.1
foreman start -f Procfile.dev
```
# App explanation

The app was build under Rails 5.1.2 and Ruby 2.4.0. It includes webpacker gem which lets us to use Webpack to manage app-like JavaScript modules in Rails. React was used in the front end with es6.

In the backend most of the logic is in the `lib` directory. Basically, a clockwork process was used to hit the XML feed, parse the response to JSON and store in Redis, when the front end hits the API endpoint the app will hit the cache store instead of hit the XML feed, this will improve the performance of the request. The explanation for this is there is a refresh rate in the XML api and the request takes almost 10 seconds to return the data and it leads the client side to wait and it's not a good idea.

You can check a detailed diagram bellow:

![Imgur](http://i.imgur.com/CBQAHoA.png)

The scheduler process will run every 5 minutes, it's the same time used by the feed, the cache is always updated when a new data is found.

The deployed version can be found here

https://desolate-anchorage-19851.herokuapp.com/
