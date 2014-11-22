
module LogRequire
  module Flat

    # Log the `require` call to STDERR or, optionally, a file
    def log_require(name)
      # cleanup the caller name (only interested in path relative to gem or lib)
      c, l = LogRequire.clean_caller(caller.first)

      elapsed = sprintf("%7.4f", Time.new.to_f - LogRequire::EPOCH)

      if LogRequire.file? then
        $log_require.puts "#{elapsed},#{name},#{c},#{l}"

      else
        pad = 110-name.length
        pad = pad > 0 ? pad : 1
        pad = (" " * pad)
        STDERR.puts "#{elapsed} require: #{name}#{pad}>> #{c}:#{l}"
      end

      return require_without_log(name)
    end

  end
end
