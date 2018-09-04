require 'rails_helper'

RSpec.describe MilestoneResource, type: :resource do
  describe 'serialization' do
    let!(:milestone) { create(:milestone, name: 'myname') }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(milestone.id)
      expect(data.jsonapi_type).to eq('milestones')
      expect(data.name).to eq('myname')
    end
  end

  describe 'filtering' do
    let!(:milestone1) { create(:milestone) }
    let!(:milestone2) { create(:milestone) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: milestone2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([milestone2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:milestone1) { create(:milestone) }
      let!(:milestone2) { create(:milestone) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            milestone1.id,
            milestone2.id
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
            milestone2.id,
            milestone1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
