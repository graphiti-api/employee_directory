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
    describe 'watchers' do
      let!(:employee1) { create(:employee) }
      let!(:employee2) { create(:employee) }
      let!(:employee3) { create(:employee) }
      let!(:department) do
        create :department,
          watcher_emails: [employee1.email, employee3.email]
      end

      before do
        params[:include] = 'watchers'
      end

      it 'sideloads employees via watcher_emails' do
        render
        sl = d[0].sideload(:watchers)
        expect(sl.map(&:id)).to eq([employee1.id, employee3.id])
        expect(sl.map(&:jsonapi_type).uniq).to eq(['employees'])
      end
    end
  end
end
