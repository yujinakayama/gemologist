module Gemologist
  # http://semver.org/
  module Version
    MAJOR = 0
    MINOR = 2
    PATCH = 0

    def self.to_s
      [MAJOR, MINOR, PATCH].join('.')
    end
  end
end
