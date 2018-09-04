require 'rails_helper'

RSpec.describe TeamResource, type: :resource do
  describe 'serialization' do
    let!(:team) { create(:team, name: 'A Team') }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(team.id)
      expect(data.jsonapi_type).to eq('teams')
      expect(data.name).to eq('A Team')
    end
  end

  describe 'filtering' do
    let!(:team1) { create(:team) }
    let!(:team2) { create(:team) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: team2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([team2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:team1) { create(:team) }
      let!(:team2) { create(:team) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            team1.id,
            team2.id
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
            team2.id,
            team1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
