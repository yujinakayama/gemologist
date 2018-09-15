# frozen_string_literal: true

require 'gemologist/ui'
require 'astrolabe/builder'
require 'parser/current'

module Gemologist
  class AbstractGemfile
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def find_dependency(name)
      dependencies.find { |dep| dep.name == name }
    end

    def dependencies
      @dependencies ||= ast.each_node.with_object([]) do |node, dependencies|
        next unless dependency_class.valid_node?(node)

        dependencies << dependency_class.new(node, source_rewriter)
      end
    end

    def save
      rewritten_source = source_rewriter.process
      File.write(path, rewritten_source)
    end

    def rewrite!
      Gemologist::UI.deprecate("#{self.class.name}##{__method__}", replacement: '#save')
      save
    end

    private

    def dependency_class
      raise NotImplementedError
    end

    def ast
      @ast ||= begin
        builder = Astrolabe::Builder.new
        parser = Parser::CurrentRuby.new(builder)
        parser.parse(source_buffer)
      end
    end

    def source_rewriter
      @source_rewriter ||= Parser::Source::TreeRewriter.new(
        source_buffer,
        crossing_deletions: :accept,
        different_replacements: :raise,
        swallowed_insertions: :raise
      )
    end

    def source_buffer
      @source_buffer ||= Parser::Source::Buffer.new(path).read
    end
  end
end
