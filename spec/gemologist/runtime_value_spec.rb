require 'gemologist/runtime_value'

module Gemologist
  RSpec.describe RuntimeValue, :ast do
    subject(:runtime_value) { RuntimeValue.new(node) }
    let(:source) { 'do_something(arg)' }

    describe '#source' do
      it 'returns the corresponding source' do
        expect(runtime_value.source).to eq(source)
      end
    end

    describe '#inspect' do
      it 'returns a string including class name and corresponding Ruby code' do
        expect(runtime_value.inspect).to eq('<Gemologist::RuntimeValue "do_something(arg)">')
      end
    end
  end
end
