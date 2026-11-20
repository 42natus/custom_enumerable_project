# frozen_string_literal: true

require_relative '../lib/my_enumerables'

RSpec.describe Enumerable do
  subject(:enumerable) { [1, 1, 2, 3, 5, 8, 13, 21, 34] }
  subject(:enumerable_2) { [1, nil, 2] }

  describe '#my_all?' do
    context 'when all elements match the condition' do
      it 'returns true' do
        expect(enumerable.my_all? { |value| value > 0 }).to eq true
      end
    end

    context 'when any element does not match the condition' do
      it 'returns false' do
        expect(enumerable.my_all? { |value| value < 5 }).to eq false
      end
    end

    # My additions: 
    # 1. Only one argument is given
    # 2. Both block and argument are given
    # 3. No block and no argument is given
    context 'when an argument is given' do
      it 'returns false' do
        expect(enumerable.my_all?(1) { |value| value < 5 }).to eq false
      end
    end

    context 'when both a block and an argument are given' do
      it 'returns false' do
        expect(enumerable.my_all?(5) { |value| value > 0 }).to eq false
      end
    end

    context 'when no block and no argument is given' do
      it 'returns true' do
        expect(enumerable.my_all?).to eq true
      end

      it 'returns false' do
        expect(enumerable_2.my_all?).to eq false
      end
    end
  end
end
