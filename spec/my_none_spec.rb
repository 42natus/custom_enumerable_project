# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Enumerable do
  subject(:enumerable) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }
  subject(:enumerable_hash) { {a: 1, b: 2, c: 3, d: 4, e: 5, f: 6} }

  describe '#my_none?' do
    context 'when no elements match the condition' do
      it 'returns true (for Array)' do
        expect(enumerable.my_none? { |value| value < 0 }).to eq true
      end

      it 'returns true (for Hash)' do
        expect(enumerable_hash.my_none? { |key, val| val < 0 }).to eq true
      end

      it 'returns true (for Hash)' do
        expect(enumerable_hash.my_none?(Hash)).to eq true
      end
    end

    context 'when any element matches the condition' do
      it 'returns false (for Array)' do
        expect(enumerable.my_none? { |value| value == 1 }).to eq false
      end

      it 'returns false (for Hash)' do
        expect(enumerable_hash.my_none? { |key, val| val == 1 }).to eq false
      end
    end
  end
end
