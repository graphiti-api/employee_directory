require 'rails_helper'

RSpec.describe DepartmentResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'departments',
          attributes: { }
        }
      }
    end

    let(:instance) do
      DepartmentResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true)
      }.to change { Department.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:department) { create(:department) }

    let(:payload) do
      {
        data: {
          id: department.id.to_s,
          type: 'departments',
          attributes: { name: 'changed!' }
        }
      }
    end

    let(:instance) do
      DepartmentResource.find(payload)
    end

    it 'works' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { department.reload.updated_at }
       .and change { department.name }.to('changed!')
    end
  end

  describe 'destroying' do
    let!(:department) { create(:department) }

    let(:instance) do
      DepartmentResource.find(id: department.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Department.count }.by(-1)
    end
  end
end
