# frozen_string_literal: true

require 'gemologist/abstract_dependency'

module Gemologist
  class Gemspec
    class Dependency < AbstractDependency
      METHOD_NAMES = %i[add_runtime_dependency add_development_dependency add_dependency].freeze

      def self.method_names
        METHOD_NAMES
      end

      def groups
        case method_name
        when :add_development_dependency
          [:development]
        else
          []
        end
      end

      private

      # https://github.com/rubygems/rubygems/blob/v2.4.5/lib/rubygems/specification.rb#L449-L473
      def version_nodes
        trailing_nodes
      end
    end
  end
end
