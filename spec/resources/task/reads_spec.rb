require 'rails_helper'

RSpec.describe TaskResource, type: :resource do
  describe 'serialization' do
    let!(:task) { create(:epic, title: 'so epic') }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(task.id)
      expect(data.jsonapi_type).to eq('epics')
      expect(data.title).to eq('so epic')
    end
  end

  describe 'filtering' do
    let!(:task1) { create(:task) }
    let!(:task2) { create(:task) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: task2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([task2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:task1) { create(:task) }
      let!(:task2) { create(:task) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            task1.id,
            task2.id
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
            task2.id,
            task1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
