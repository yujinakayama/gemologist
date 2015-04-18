require 'gemologist/gemfile_lock'

module Gemologist
  RSpec.describe GemfileLock, :lockfile do
    include FileHelper
    include_context 'isolated environment'

    describe '#find_dependency' do
      it 'returns the dependency matching the passed name' do
        dependency = lockfile.find_dependency('rspec')
        expect(dependency.name).to eq('rspec')
      end
    end

    describe '#dependencies' do
      let(:dep_names) { lockfile.dependencies.map(&:name) }

      it 'returns an array of the specifications' do
        expect(dep_names).to include('rake', 'rspec', 'rubocop')
      end
    end
  end
end
