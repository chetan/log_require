
require "log_require/node"

module LogRequire

  def self.graph?
    !ENV["LOG_REQUIRE_GRAPH"].nil?
  end

  def self.file?
    !ENV["LOG_REQUIRE"].nil?
  end

  if graph?
    require "log_require/graph"
  else
    require "log_require/flat"
  end

  EPOCH = Time.new.to_f

  def self.setup
    io = if file? then
      File.open(ENV["LOG_REQUIRE"], 'w')
    else
      STDERR
    end

    if graph? then
      $log_require_stack = []
      $log_require_frame = Node.root
      Kernel.include(LogRequire::Graph)
      at_exit do
        io.puts
        io.puts LogRequire::Node.root.to_graph_s()
        LogRequire::Node.root.print_children(io)
      end

    else
      $log_require = io
      if file? then
        io.puts "elapsed time,require name,caller,line number"
      end
      Kernel.include(LogRequire::Flat)
    end
  end

  def self.clean_caller(c)
    if c =~ %r{ruby-[\d.]+/gems/(.*):(\d+):in `.*$} ||
       c =~ %r{(ruby-[\d.]+/lib/ruby/[\d.]+/.*):(\d+):in `.*$} ||
       c =~ %r{(ruby/site_ruby/[\d.]+/.*):(\d+):in `.*$} ||
       c =~ %r{^(.*?):(\d+):in `.*$} then

       return [$1, $2]
    end
  end

  def self.find_caller(arr, c)
    arr.each do |s|
      if s =~ /#{c}:\d+:in/ then
        return true
      end
    end
    false
  end
end

module Kernel

  if !method_defined?(:log_require) then
    LogRequire.setup
    alias_method :require_without_log, :require
    alias_method :require, :log_require
  end

end
