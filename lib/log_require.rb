
module LogRequire
  def self.clean_caller(c)
    if c =~ %r{ruby-[\d.]+/gems/(.*):(\d+):in `.*$} ||
       c =~ %r{(ruby-[\d.]+/lib/ruby/[\d.]+/.*):(\d+):in `.*$} ||
       c =~ %r{(ruby/site_ruby/[\d.]+/.*):(\d+):in `.*$} ||
       c =~ %r{^(.*?):(\d+):in `.*$} then

       return [$1, $2]
    end
  end
end

module Kernel

  if !method_defined?(:log_require) then

    # Log the `require` call to STDERR or, optionally, a file
    def log_require(name)

      # cleanup the caller name (only interested in path relative to gem or lib)
      c = caller.first
      c, l = LogRequire.clean_caller(c)

      if ENV["LOG_REQUIRE"] then
        if $log_require.nil? then
          $log_require = File.open(ENV["LOG_REQUIRE"], 'w')
          $log_require.puts "require name,caller,line number"
        end
        $log_require.puts "#{name},#{c},#{l}"

      else
        pad = 110-name.length
        pad = pad > 0 ? pad : 1
        pad = (" " * pad)
        STDERR.puts "require: #{name}#{pad}>> #{c}:#{l}"
      end

      return require_without_log(name)
    end
    alias_method :require_without_log, :require
    alias_method :require, :log_require
  end

end
