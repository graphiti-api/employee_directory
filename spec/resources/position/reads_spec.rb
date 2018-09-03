require 'rails_helper'

RSpec.describe PositionResource, type: :resource do
  describe 'serialization' do
    let!(:position) { create(:position, attrs) }

    let(:attrs) do
      {
        title: 'ruby developer',
        active: false
      }
    end

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(position.id)
      expect(data.jsonapi_type).to eq('positions')
      expect(data.title).to eq('ruby developer')
      expect(data.active).to eq(false)
    end
  end

  describe 'filtering' do
    let!(:position1) { create(:position) }
    let!(:position2) { create(:position) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: position2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([position2.id])
      end
    end

    context 'by current' do
      let!(:position1) { create(:position, historical_index: 2) }
      let!(:position2) { create(:position, historical_index: 1) }

      before do
        params[:filter] = { current: true }
      end

      it 'only returns positions where historical index == 1' do
        render
        expect(d.map(&:id)).to eq([position2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:position1) { create(:position) }
      let!(:position2) { create(:position) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            position1.id,
            position2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            position2.id,
            position1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
