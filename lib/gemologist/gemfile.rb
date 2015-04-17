require 'gemologist/abstract_gemfile'

module Gemologist
  class Gemfile < AbstractGemfile
    require 'gemologist/gemfile/dependency'

    private

    def dependency_class
      Gemfile::Dependency
    end
  end
end
