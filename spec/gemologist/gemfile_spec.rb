# frozen_string_literal: true

require 'gemologist/gemfile'

module Gemologist
  RSpec.describe Gemfile, :gemfile do
    include FileHelper
    include_context 'isolated environment'

    describe '#find_dependency' do
      it 'returns the dependency matching the passed name' do
        dependency = gemfile.find_dependency('rspec')
        expect(dependency.name).to eq('rspec')
      end
    end

    describe '#dependencies' do
      it 'returns an array of the dependencies' do
        expect(gemfile.dependencies.size).to eq(3)
        expect(gemfile.dependencies).to all be_a(Gemfile::Dependency)
      end
    end

    describe '#rewrite!' do
      it 'is deprecated in favor of #save' do
        expect(gemfile).to receive(:save)
        expect { gemfile.rewrite! }.to output(/deprecated.+#save/).to_stderr
      end
    end
  end
end
