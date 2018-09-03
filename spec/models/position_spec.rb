require 'rails_helper'

RSpec.describe Position do
  describe 'scopes' do
    describe '.current' do
      subject { described_class.current }

      let!(:pos1) { create(:position, historical_index: 2) }
      let!(:pos2) { create(:position, historical_index: 1) }

      it 'finds all positions that are historical index 1' do
        expect(subject).to eq([pos2])
      end
    end
  end
end
