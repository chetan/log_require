# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "log_require"
  gem.homepage = "http://github.com/chetan/log_require"
  gem.license = "MIT"
  gem.summary = %Q{Log all calls to Kernel#require}
  gem.description = %Q{Small utility to help track down that stray library}
  gem.email = "chetan@pixelcop.net"
  gem.authors = ["Chetan Sarva"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'yard'
YARD::Rake::YardocTask.new

task :default => :build
