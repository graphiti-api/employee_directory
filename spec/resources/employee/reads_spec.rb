require 'rails_helper'

RSpec.describe EmployeeResource, type: :resource do
  describe 'serialization' do
    let!(:employee) { create(:employee, attrs) }

    let(:attrs) do
      {
        first_name: 'jane',
        last_name: 'doe',
        age: 40
      }
    end

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(employee.id)
      expect(data.jsonapi_type).to eq('employees')
      expect(data.first_name).to eq('jane')
      expect(data.last_name).to eq('doe')
      expect(data.age).to eq(40)
      expect(data.created_at).to eq(datetime(employee.created_at))
      expect(data.updated_at).to eq(datetime(employee.updated_at))
    end
  end

  describe 'filtering' do
    let!(:employee1) { create(:employee) }
    let!(:employee2) { create(:employee) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: employee2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([employee2.id])
      end
    end

    describe 'by title' do
      let!(:employee3) { create(:employee) }

      # correct title, but not current
      let!(:pos1) do
        create :position,
          employee: employee1,
          title: 'manager',
          historical_index: 2
      end
      # wrong title
      let!(:pos2) do
        create :position,
          employee: employee3,
          title: 'engineer',
          historical_index: 1
      end
      # good!
      let!(:pos3) do
        create :position,
          employee: employee2,
          title: 'manager',
          historical_index: 1
      end

      before do
        params[:filter] = { title: 'manager' }
      end

      it 'returns employees who have a current position with the given title' do
        render
        expect(d.map(&:id)).to eq([employee2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:employee1) { create(:employee) }
      let!(:employee2) { create(:employee) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            employee1.id,
            employee2.id
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
            employee2.id,
            employee1.id
          ])
        end
      end
    end

    describe 'by title' do
      let!(:employee1) { create(:employee) }
      let!(:employee2) { create(:employee) }
      let!(:pos1) { create(:position, employee: employee1, title: 'x') }
      let!(:pos2) do
        create(:position, employee: employee2, title: 'z', historical_index: 2)
      end
      let!(:pos3) { create(:position, employee: employee2, title: 'a') }

      context 'when asc' do
        before do
          params[:sort] = 'title'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([employee2.id, employee1.id])
        end
      end

      context 'when desc' do
        before do
          params[:sort] = '-title'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([employee1.id, employee2.id])
        end
      end
    end

    describe 'by department name' do
      let!(:employee1) { create(:employee) }
      let!(:employee2) { create(:employee) }
      let!(:pos1) do
        create(:position, employee: employee1, department: department1)
      end
      let!(:pos2) do
        create :position,
          employee: employee2,
          department: department2,
          historical_index: 2
      end
      let!(:pos3) do
        create :position,
          employee: employee2,
          department: department3
      end

      let!(:department1) { create(:department, name: 'z') }
      let!(:department2) { create(:department, name: 'a') }
      let!(:department3) { create(:department, name: 'b') }

      context 'when asc' do
        before do
          params[:sort] = 'department_name'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([employee2.id, employee1.id])
        end
      end

      context 'when desc' do
        before do
          params[:sort] = '-department_name'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([employee1.id, employee2.id])
        end
      end
    end
  end

  describe 'sideloading' do
    describe 'departments' do
      let!(:employee) { create(:employee) }
      let!(:position1) do
        create :position,
          historical_index: 2,
          employee: employee,
          department: department1
      end
      let!(:position2) do
        create :position,
          historical_index: 1,
          employee: employee,
          department: department2
      end
      let!(:department1) { create(:department) }
      let!(:department2) { create(:department) }

      before do
        params[:include] = 'departments'
      end

      it 'finds the departments for all positions' do
        render
        sl = d[0].sideload(:departments)
        expect(sl.map(&:id)).to eq([department1.id, department2.id])
        expect(sl.map(&:jsonapi_type).uniq).to eq(['departments'])
      end
    end

    describe 'current_position' do
      let!(:pos1) do
        create(:position, employee: employee, historical_index: 2)
      end
      let!(:pos2) do
        create(:position, employee: employee, historical_index: 1)
      end

      before do
        params[:include] = 'current_position'
      end

      it 'returns position with historical index == 1' do
        render
        sl = d[0].sideload(:current_position)
        expect(sl.jsonapi_type).to eq('positions')
        expect(sl.id).to eq(pos2.id)
      end
    end
  end
end
