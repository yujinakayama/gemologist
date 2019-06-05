# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gemologist/version'

Gem::Specification.new do |spec|
  spec.name          = 'gemologist'
  spec.version       = Gemologist::Version.to_s
  spec.authors       = ['Yuji Nakayama']
  spec.email         = ['nkymyj@gmail.com']

  spec.summary       = 'A library for rewriting your Gemfile and gemspec.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/yujinakayama/gemologist'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3'

  spec.add_runtime_dependency 'astrolabe', '~> 1.3'
  spec.add_runtime_dependency 'bundler', '>= 1.7'
  spec.add_runtime_dependency 'parser', '>= 2.5.0.0'
end
