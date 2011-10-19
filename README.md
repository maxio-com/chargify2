Chargify API V2 Ruby Wrapper [![build status](https://secure.travis-ci.org/chargify/chargify2.png)](http://travis-ci.org/chargify/chargify2)
============================

This gem is meant to be used with the [Chargify Direct API](http://docs.chargify.com/chargify-direct-introduction).

You'll need Chargify Direct credentials to interact with the Chargify V2 API, which you can get by [opening a support ticket](http://help.chargify.com/anonymous_requests/new).

Getting Started
---------------

Install the gem, or add it to your Gemfile:
    
    gem install chargify2

Sample Code
-----------

Check out the [Chargify Direct Example App](https://github.com/chargify/chargify_direct_example) for usage examples.

View a *call* resource:

``` ruby
chargify = Chargify2::Client.new(:api_id => "f43ee0a0-4356-012e-0f5f-0025009f114a", :api_password => 'direct777test', :base_uri => "http://app.chargify.local/api/v2")
call = chargify.calls.read("4dbc42ecc21d93ec8f9bb581346dd41c5c3c2cf5")
```

Contributing
------------

**What to contribute:**

* Check out the project's [issues page](https://github.com/chargify/chargify2/issues)
* Refactor something that looks messy to you!

**How to contribute:**

* Fork the project.
* Implement your feature on a topic branch.
* Add tests for it.  This is important so we don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.  If you want to have your own version, that's fine but bump version in acommit by itself that we can ignore when we pull.
* Send us a pull request.
 
Copyright
---------

Copyright (c) 2011 Chargify. See LICENSE.txt for further details.
