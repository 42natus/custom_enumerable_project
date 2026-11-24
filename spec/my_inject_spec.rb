# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Enumerable do
  subject(:enumerable) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }
  subject(:enumerable_hash) { {a: 1, b: 2, c: 3} }

  describe '#my_inject' do
    it '(Array) reduces an enumerable to a single value' do
      initial_value = 0
      # calculates the sum of the elements of the enumerable array
      expect(enumerable.my_inject(initial_value) { |sum, value| sum + value }).to eq 88
    end

    it '(Hash) reduces an enumerable to a single value' do
      initial_value = []

      expect(enumerable_hash.my_inject(initial_value) { |result, next_value| result << next_value }).
      to eq [[:a, 1], [:b, 2], [:c, 3]]
    end

    it '(Array) can be used to calculate the product' do
      product = enumerable.my_inject(1) { |prod, value| prod * value }

      expect(product).to eq 2_227_680
    end

    it '(Array) uses the initial value on the first iteration' do
      initial_value = 100
      # calculates the sum of the elements of the enumerable array plus the initial value
      expect(enumerable.my_inject(initial_value) { |sum, value| sum + value }).to eq 188
    end

    it '(Hash) uses the initial value on the first iteration' do
      initial_value = [:start]

      expect(enumerable_hash.my_inject(initial_value) { |result, next_value| result << next_value }).
      to eq [:start, [:a, 1], [:b, 2], [:c, 3]]
    end
  end
end
