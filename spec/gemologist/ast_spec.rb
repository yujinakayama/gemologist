# frozen_string_literal: true

require 'gemologist/ast'

module Gemologist
  RSpec.describe AST, :ast do
    describe '.concretize' do
      subject(:concretized_value) { AST.concretize(node) }

      [
        true,
        false,
        nil,
        123,
        3.14,
        'foo',
        :foo,
        //im,
        /foo/im,
        ['foo', 123],
        { 'foo' => 123, bar: false },
        1..3,
        1...3,
        { 'foo' => [:bar, { baz: 3.14 }] }
      ].each do |value|
        context "with #{value.inspect} node" do
          let(:source) { value.inspect }

          it "returns #{value.inspect}" do
            expect(concretized_value).to eq(value)
          end
        end
      end

      context 'with a regexp node only with interpolation' do
        let(:source) { '/#{do_something}/' }

        it 'returns a RuntimeValue' do
          expect(concretized_value).to be_a(RuntimeValue)
        end
      end

      context 'with a regexp node including interpolation' do
        let(:source) { '/foo#{do_something}/' }

        it 'returns a RuntimeValue' do
          expect(concretized_value).to be_a(RuntimeValue)
        end
      end

      context 'with a non-literal node' do
        let(:source) { 'do_something' }

        it 'returns a RuntimeValue' do
          expect(concretized_value).to be_a(RuntimeValue)
        end
      end

      context 'with an array node including non-literal element' do
        let(:source) { '[1, do_something]' }

        it 'returns an array including a RuntimeValue' do
          expect(concretized_value).to match([1, an_instance_of(RuntimeValue)])
        end
      end

      context 'when nil is passed' do
        let(:node) { nil }
        it { should be_nil }
      end
    end
  end
end
