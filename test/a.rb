#!/usr/bin/env ruby

# expected output:
#
# a -> b -> c -> openssl
# d -> e -> f
#   -> g

require "./b.rb"
require "./d.rb"

