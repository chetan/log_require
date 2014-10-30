
module LogRequire
  class Node

    attr_reader :parent, :caller, :name, :children
    attr_accessor :result

    def initialize(parent, caller, name, dupe_caller=false)
      @parent      = parent
      @caller      = caller
      @name        = name
      @children    = []
      @dupe_caller = dupe_caller
      @result      = false
    end

    def self.root
      @root ||= new(nil, nil, :root)
    end

    def parent
      if root? then
        self
      else
        @parent
      end
    end

    def root?
      @parent.nil? && @name == :root
    end

    def add_child(caller, name)
      dupe_caller = (!@children.empty? and @children.last.caller == caller)
      @children << (node = Node.new(self, caller, name, dupe_caller))
      node
    end

    def print_children(io, indent=1)
      @children.each do |child|
        io.puts child.to_graph_s(indent)
        child.print_children(io, indent+2)
      end
    end

    def to_graph_s(indent=1)
      if root? then
        "--+ root"
      else
        s = ""
        s += "#{'|  '*indent}|--+ #{@caller}\n" if !@dupe_caller
        s += "#{'|  '*(indent+1)}|--" + (@children.empty?() ? "=" : "+") + " #{@name}" +
          (@result ? "" : " (#{@result})")
        s
      end
    end

    def to_s
      "#{@caller} -> #{@name} (#{@result})"
    end

  end
end
