Chargify V2 API Ruby Wrapper
============================

    chargify = Chargify2::Client.new(:api_id => "f43ee0a0-4356-012e-0f5f-0025009f114a", :api_password => 'direct777test', :base_uri => "http://app.chargify.local/api/v2")
    call = chargify.calls.read("4dbc42ecc21d93ec8f9bb581346dd41c5c3c2cf5")

Contributing to Chargify2
-------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright (c) 2011 Chargify. See LICENSE.txt for
further details.

