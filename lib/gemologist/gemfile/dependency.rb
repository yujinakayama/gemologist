require 'gemologist/abstract_dependency'
require 'gemologist/util'

module Gemologist
  class Gemfile
    class Dependency < AbstractDependency
      include Util

      METHOD_NAMES = [:gem].freeze

      def self.method_names
        METHOD_NAMES
      end

      def groups
        @groups ||= (groups_via_block + groups_via_option).map(&:to_sym)
      end

      def options
        @options ||= symbolize_keys(AST.concretize(options_node) || {})
      end

      private

      def groups_via_block
        return [] unless group_node
        _receiver_node, _message, *arg_nodes = *group_node
        arg_nodes.map { |node| AST.concretize(node) }
      end

      def groups_via_option
        Array(options[:group])
      end

      # https://github.com/bundler/bundler/blob/v1.7.11/lib/bundler/dsl.rb#L68-L70
      def version_nodes
        @version_nodes ||= trailing_nodes - [options_node]
      end

      def options_node
        node = trailing_nodes.last

        if node && node.hash_type?
          node
        else
          nil
        end
      end

      def group_node
        candidates = node.each_ancestor(:block).map { |block_node| block_node.children.first }

        candidates.find do |send_node|
          receiver_node, message, = *send_node
          receiver_node.nil? && message == :group
        end
      end
    end
  end
end
