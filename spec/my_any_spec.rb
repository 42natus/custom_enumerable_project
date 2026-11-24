# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Enumerable do
  subject(:enumerable) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }
  subject(:enumerable_hash) { {a: 1, b: 2, c: 3, d: 4, e: 5, f: 6} }

  describe '#my_any?' do
    context 'when any element matches the condition' do
      it 'returns true (for arrays)' do
        expect(enumerable.my_any?(&:even?)).to eq true
      end

      it 'returns true (for hashes)' do
        expect(enumerable_hash.my_any?(Array)).to eq true
      end

      it 'returns true (for hashes)' do
        expect(enumerable_hash.my_any? { |k, v| v.eql?(5) }).to eq true
      end
    end

    context 'when no element matches the condition' do
      it 'returns false (for arrays)' do
        expect(enumerable.my_any?(&:negative?)).to eq false
      end

      it 'returns false (for hashes)' do
        expect(enumerable_hash.my_any?(Hash)).to eq false
      end
    end
  end
end
