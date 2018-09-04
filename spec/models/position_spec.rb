require 'rails_helper'

RSpec.describe Position do
  describe 'scopes' do
    describe '.current' do
      subject { described_class.current(value) }

      let!(:pos1) { create(:position, historical_index: 1) }
      let!(:pos2) { create(:position, historical_index: 2) }

      context 'when true' do
        let(:value) { true }

        it 'finds all positions that are historical index 1' do
          expect(subject).to eq([pos1])
        end
      end

      context 'when false' do
        let(:value) { false }

        it 'finds all positions that are not historical index 1' do
          expect(subject).to eq([pos2])
        end
      end
    end

    describe '.reorder!' do
      let!(:employee) { create(:employee) }
      let!(:pos1) do
        create(:position, employee: employee, historical_index: 2)
      end
      let!(:pos2) do
        create(:position, employee: employee, historical_index: 3)
      end
      let!(:pos3) do
        create(:position, employee: employee, historical_index: 1)
      end
      let!(:pos4) do
        create(:position, employee: employee, historical_index: 4)
      end

      it 'updates historical index based on recency' do
        Position.reorder!(employee.id)
        indices = [pos1, pos2, pos3, pos4]
        indices.each(&:reload)
        expect(indices.map(&:historical_index)).to eq([4, 3, 2, 1])
      end
    end
  end
end
