# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Enumerable do
  subject(:enumerable) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }
  subject(:enumerable_hash) { {a: 1, b: 2, c: 3, d: 4, e: 5, f: 6} }

  describe '#my_count' do
    context 'when not given a block' do
      it 'returns the size of the enumerable' do
        expect(enumerable.my_count).to eq enumerable.size
      end

      it 'returns the size of the enumerable (hash)' do
        expect(enumerable_hash.my_count).to eq enumerable_hash.size
      end
    end

    context 'when given a block' do
      it 'returns the count of the elements that satisfy the condition' do
        expect(enumerable.my_count { |value| value > 5 }).to eq 4
        expect(enumerable.my_count { |value| value <= 5 }).to eq 5
        expect(enumerable.my_count { |value| value == 5 }).to eq 1
      end

      it 'returns the count of key/value pairs that satisfy the condition' do
        expect(enumerable_hash.my_count { |key, val| val > 5 }).to eq 1
        expect(enumerable_hash.my_count { |key, val| val <= 5 }).to eq 5
        expect(enumerable_hash.my_count { |key, val| val == 5 }).to eq 1
      end
    end

    context 'when given an object' do
      it 'returns the count of the object in the enumerable' do
        expect(enumerable.my_count(1)).to eq 2
      end

      it 'returns the count of the object in the enumerable (hash)' do
        expect(enumerable_hash.my_count([:a, 1])).to eq 1
      end
    end
  end
end
