require 'gemologist/abstract_gemfile'

module Gemologist
  class Gemspec < AbstractGemfile
    require 'gemologist/gemspec/dependency'

    private

    def dependency_class
      Gemspec::Dependency
    end
  end
end
