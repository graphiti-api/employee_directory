require 'rails_helper'

RSpec.describe TeamResource, type: :resource do
  describe 'creating' do
    let!(:department) { create(:department) }

    let(:payload) do
      {
        data: {
          type: 'teams',
          attributes: { },
          relationships: {
            department: {
              data: {
                id: department.id.to_s,
                type: 'departments'
              }
            }
          }
        }
      }
    end

    let(:instance) do
      TeamResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true)
      }.to change { Team.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:team) { create(:team) }

    let(:payload) do
      {
        data: {
          id: team.id.to_s,
          type: 'teams',
          attributes: { name: 'changed!' }
        }
      }
    end

    let(:instance) do
      TeamResource.find(payload)
    end

    it 'works' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { team.reload.updated_at }
       .and change { team.name }.to('changed!')
    end
  end

  describe 'destroying' do
    let!(:team) { create(:team) }

    let(:instance) do
      TeamResource.find(id: team.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Team.count }.by(-1)
    end
  end
end
