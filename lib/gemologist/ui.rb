module Gemologist
  module UI
    module_function

    def deprecate(deprecated, options = {})
      message = "DEPRECATION: #{deprecated} is deprecated."
      message << " Use #{options[:replacement]} instead." if options[:replacement]
      warn message
    end
  end
end
