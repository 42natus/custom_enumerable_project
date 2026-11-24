# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Enumerable do
  subject(:enumerable) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }
  subject(:enumerable_hash) { {a: 1, b: 2, c: 3, d: 4, e: 5, f: 6} }

  describe '#my_select' do
    context 'when given a block' do
      it 'returns only the values that match the condition' do
        expect(enumerable.my_select { |value| value > 10 }).to eq([13, 21, 34])
      end

      it '(hash) returns only the values that match the condition' do
        expect(enumerable_hash.my_select { |key, value| value > 3 }).to eq({d: 4, e: 5, f: 6})
      end

      it 'filters values that do not match the condition' do
        expect(enumerable.my_select { |value| value > 10 }).not_to include(1, 2, 3, 5, 8)
      end

      it '(hash) filters values that do not match the condition' do
        expect(enumerable_hash.my_select { |key, value| value > 3 }).not_to include(:a, :b, :c)
      end

      it 'returns an empty array when no items match the condition' do
        expect(enumerable.my_select { |value| value > 40 }).to eq([])
      end

      it '(hash) returns an empty hash when no items match the condition' do
        expect(enumerable_hash.my_select { |key, value| value > 10 }).to eq({})
      end
    end

    context 'when not given a block' do
      it 'returns an Enumerator' do
        expect(enumerable.my_select).to be_a Enumerator
      end

      it '(hash) returns an Enumerator' do
        expect(enumerable_hash.my_select).to be_a Enumerator
      end

      it 'contains the elements of the receiving array' do
        expect(enumerable.my_select.to_a).to eq enumerable
      end

      it '(hash) contains the elements of the receiving hash' do
        expect(enumerable_hash.my_select.to_h).to eq enumerable_hash
      end
    end
  end
end
