# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Hash do
  subject(:hash) { {a: 1, b: 2, c: 3, d: 4, e: 5, f: 6} }

  describe '#my_each_pair' do
    context 'when given a block' do
      it 'returns the original hash' do
        my_each_pair_results = hash.my_each_pair { |_key, _value| }

        expect(my_each_pair_results).to eq(hash)
      end

      it 'executes the block for each pair' do
        my_each_pair_results = []
        each_pair_results = []

        hash.my_each_pair do |key, value|
          my_each_pair_results << "#{key}: #{value * 2}"
        end

        hash.each_pair do |key, value|
          each_pair_results << "#{key}: #{value * 2}"
        end

        expect(my_each_pair_results).to eq(each_pair_results)
      end
    end

    context 'when not given a block' do
      it 'returns an Enumerator' do
        expect(hash.my_each_pair).to be_a Enumerator
      end

      it 'contains the elements of the receiving hash' do
        expect(hash.my_each_pair.to_h).to eq hash
      end
    end
  end
end
