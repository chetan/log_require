# log_require

Log all calls to Kernel#require

## Usage

This library should generally not be added to a `Gemfile`. Simply install it: 

```bash
$ gem install log_require
```

Then use it like so:

```text
$ ruby -rlog_require ./a.rb
require: ./b.rb             >> ./a.rb:9
require: ./c.rb             >> ./b.rb:2
require: openssl            >> ./c.rb:2
require: openssl.so         >> ruby-2.1.3/lib/ruby/2.1.0/openssl.rb:17
require: digest.so          >> ruby-2.1.3/lib/ruby/2.1.0/digest.rb:1
require: openssl/bn         >> ruby-2.1.3/lib/ruby/2.1.0/openssl.rb:19
require: openssl/cipher     >> ruby-2.1.3/lib/ruby/2.1.0/openssl.rb:20
require: openssl/config     >> ruby-2.1.3/lib/ruby/2.1.0/openssl.rb:21
require: stringio           >> ruby-2.1.3/lib/ruby/2.1.0/openssl/config.rb:13
require: openssl/digest     >> ruby-2.1.3/lib/ruby/2.1.0/openssl.rb:22
require: openssl/x509       >> ruby-2.1.3/lib/ruby/2.1.0/openssl.rb:23
require: openssl/ssl        >> ruby-2.1.3/lib/ruby/2.1.0/openssl.rb:24
require: openssl/buffering  >> ruby-2.1.3/lib/ruby/2.1.0/openssl/ssl.rb:17
require: fcntl              >> ruby-2.1.3/lib/ruby/2.1.0/openssl/ssl.rb:18
require: ./d.rb             >> ./a.rb:10
require: ./e.rb             >> ./d.rb:2
require: ./f.rb             >> ./e.rb:2
require: ./g.rb             >> ./d.rb:3
```

Output is written to STDERR by default.

The following environment variables can also be used to control the output:

* LOG_REQUIRE="filename" -- write to file instead of STDERR
* LOG_REQUIRE_GRAPH=1 -- display tree output

## Contributing to log_require
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Chetan Sarva. See LICENSE.txt for
further details.

