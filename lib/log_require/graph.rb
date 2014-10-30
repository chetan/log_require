
module LogRequire
  module Graph

    def log_require(name)
      # cleanup the caller name (only interested in path relative to gem or lib)
      stack = caller
      c, l = LogRequire.clean_caller(stack.first)

      # clean up the require stack
      while !LogRequire.find_caller(stack, $log_require_stack.last) do
        $log_require_stack.pop
      end

      # cleanup the frame pointer
      while !LogRequire.find_caller(stack, $log_require_frame.caller) do
        $log_require_frame = $log_require_frame.parent
      end

      while !$log_require_frame.root?() &&
        ($log_require_frame.caller == $log_require_frame.parent.caller || $log_require_frame.caller == c) do

        $log_require_frame = $log_require_frame.parent
      end

      # add on to the stack
      if ! $log_require_stack.include?(c) then
        $log_require_stack << c
      end

      # log the node
      new_node = $log_require_frame.add_child(c, name)
      $log_require_frame = new_node

      # dot he actual require
      new_node.result = require_without_log(name)
    end

  end
end
