ask_geo
=======

Ruby client library for the [AskGeo](http://www.askgeo.com/) web service. From the AskGeo website:

> AskGeo provides a simple, fast, and accurate web api for finding out the time zone information for a given location (latitude and longitude). It's simple: you give latitude and longitude and the API returns a time zone ID (e.g., "America/Chicago", or "Europe/London"). We built the API because we needed it for a different project and decided to make it available because no other such tools seem to exist that are accurate and capable of returning a large number of results in a short period of time.
>
> Unlike GeoNames, look-ups are based on an actual map of the world, rather than "closest point of interest", which ensures accuracy and that you actually get a result for all locations. And unlike EarthTools, we return an actual time zone ID (e.g., "America/Los_Angeles") rather than just an offset. The API is also very fast: when used in batch mode, it is capable of returning thousands of results in a couple seconds.

Installation
============

Install the gem:

    gem install ask_geo

Or, if you are using bundler, add it to your Gemfile:

    gem "ask_geo"

Usage
=====

First, you will need to create an [AskGeo](http://www.askgeo.com/) account. Currently they only support doing this via OpenID with a gmail account. Once you have created an account, they give you an Account ID and an API Key. You will need those to make calls to their web service through this library.

From there, usage of the client library is fairly straight-forward:

```ruby
# Instantiate a client
client = AskGeo.new(:account_id => 'XXXXXX', :api_key => 'XXXXXX')

# Lookup a single lat/lon
resp = client.lookup("47.62057,-122.349761")
# => {
#      "timeZone" => "America/Los_Angeles",
#      "currentOffsetMs" => -25200000,
#      "latitude" => 47.62057,
#      "longitude" => -122.349761
#    }

# Lookup a batch of lat/lon points (faster than multiple calls)
resp = client.lookup(["47.62057,-122.349761", "40.748529,-73.98563"])
# => [{
#       "timeZone" => "America/Los_Angeles",
#       "currentOffsetMs" => -25200000,
#       "latitude" => 47.62057,
#       "longitude" => -122.349761
#     },
#     {
#       "timeZone" => "America/New_York",
#       "currentOffsetMs" => -14400000,
#       "latitude" => 40.748529,
#       "longitude" => -73.98563
#     }]

# Points can be specified by Hash too...
resp = client.lookup(:lat => 47.62057, :lon => -122.349761)

resp = client.lookup(
  [
    {:lat => 47.62057, :lon => -122.349761},
    {:lat => 40.748529, :lon => -73.98563}
  ]
)
```

Contributing to ask_geo
=======================
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Running the Tests
=================

In order to run the tests, you first need to edit `spec/spec_helper.rb` and follow the `TODO` comment to insert your AskGeo account ID and API key. Then, you should be able to run the tests with:

```
rake spec
```

Copyright
=========

Copyright (c) 2011 Scott W. Bradley. See LICENSE.txt for
further details.

AskGeo, GeoNames, and EarthTools are copyright/trademark their respective owners.
