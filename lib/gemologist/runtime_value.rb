module Gemologist
  class RuntimeValue
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def source
      @source ||= node.loc.expression.source
    end

    def inspect
      "<#{self.class.name} #{source.inspect}>"
    end
  end
end
