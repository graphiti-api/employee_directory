require 'rails_helper'

RSpec.describe Position do
  describe 'scopes' do
    describe '.current' do
      subject { described_class.current(value) }

      let!(:pos1) { create(:position, historical_index: 2) }
      let!(:pos2) { create(:position, historical_index: 1) }

      context 'when true' do
        let(:value) { true }

        it 'finds all positions that are historical index 1' do
          expect(subject).to eq([pos2])
        end
      end

      context 'when false' do
        let(:value) { false }

        it 'finds all positions that are not historical index 1' do
          expect(subject).to eq([pos1])
        end
      end
    end
  end
end
