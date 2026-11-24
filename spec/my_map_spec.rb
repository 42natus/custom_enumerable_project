# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Enumerable do
  subject(:enumerable) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }
  subject(:enumerable_hash) { {a: 1, b: 2, c: 3, d: 4, e: 5, f: 6} }

  describe '#my_map' do
    context 'when given a block' do
      it '(Array) returns an array by yielding to the block' do
        expect(enumerable.my_map { |value| value * 2 }).to eq([2, 2, 4, 6, 10, 16, 26, 42, 68])
      end

      it '(Array) returns an array with the same size as the enumerable' do
        expect(enumerable.my_map { |value| value * 2 }.size).to eq enumerable.size
      end

      it '(Hash) returns an array by yielding to the block' do
        expect(enumerable_hash.my_map { |key, val| val * 2 }).to eq([2, 4, 6, 8, 10, 12])
      end

      it '(Hash) returns an array with the same size as the enumerable' do
        expect(enumerable_hash.my_map { |key, val| val * 2 }.size).to eq enumerable_hash.size
      end
    end

    context 'when called with &:symbol' do
      it '(Array) returns an array calling the method that matches the symbol for each element' do
        expect(enumerable.my_map(&:odd?)).to eq([true, true, false, true, true, false, true, true, false])
      end
    end

    context 'when not given a block' do
      it '(Array) returns an Enumerator' do
        expect(enumerable.my_map).to be_a Enumerator
      end

      it '(Array) contains the elements of the receiving array' do
        expect(enumerable.my_map.to_a).to eq enumerable
      end

      it '(Hash) returns an Enumerator' do
        expect(enumerable_hash.my_map).to be_a Enumerator
      end

      it '(Hash) contains the elements of the receiving hash' do
        expect(enumerable_hash.my_map.to_h).to eq enumerable_hash
      end
    end
  end
end
