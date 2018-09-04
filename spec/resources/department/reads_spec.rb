require 'rails_helper'

RSpec.describe DepartmentResource, type: :resource do
  describe 'serialization' do
    let!(:department) { create(:department, name: 'my department') }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(department.id)
      expect(data.jsonapi_type).to eq('departments')
      expect(data.name).to eq('my department')
    end
  end

  describe 'filtering' do
    let!(:department1) { create(:department) }
    let!(:department2) { create(:department) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: department2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([department2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:department1) { create(:department) }
      let!(:department2) { create(:department) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            department1.id,
            department2.id
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
            department2.id,
            department1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
