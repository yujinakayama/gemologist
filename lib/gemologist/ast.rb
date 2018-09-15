# frozen_string_literal: true

require 'gemologist/runtime_value'

module Gemologist
  module AST
    module_function

    def concretize(node) # rubocop:disable MethodLength, CyclomaticComplexity
      return nil unless node

      case node.type
      when :true                    then true
      when :false                   then false
      when :nil                     then nil
      when :int, :float, :str, :sym then node.children.first
      when :irange, :erange         then concretize_range(node)
      when :regexp                  then concretize_regexp(node)
      when :array                   then concretize_array(node)
      when :hash                    then concretize_hash(node)
      else                               RuntimeValue.new(node)
      end
    end

    def concretize_range(range_node)
      values = range_node.children.map { |child_node| concretize(child_node) }
      Range.new(*values, range_node.type == :erange)
    end

    def concretize_regexp(regexp_node)
      *body_nodes, regopt_node = *regexp_node
      return RuntimeValue.new(regexp_node) unless body_nodes.all?(&:str_type?)

      string = body_nodes.map { |str_node| str_node.children.first }.reduce(:+)
      options = regopt_node.children.map(&:to_s).reduce(:+)
      eval("/#{string}/#{options}", binding, __FILE__, __LINE__) # rubocop:disable Eval
    end

    def concretize_array(array_node)
      array_node.children.map { |child_node| concretize(child_node) }
    end

    def concretize_hash(hash_node)
      hash_node.children.each_with_object({}) do |pair_node, hash|
        key_node, value_node = *pair_node
        key = concretize(key_node)
        hash[key] = concretize(value_node) if key
      end
    end
  end
end
