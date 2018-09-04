require 'rails_helper'

RSpec.describe MilestoneResource, type: :resource do
  describe 'creating' do
    let!(:epic) { create(:epic) }

    let(:payload) do
      {
        data: {
          type: 'milestones',
          attributes: { },
          relationships: {
            epic: {
              data: {
                type: 'epics',
                id: epic.id.to_s
              }
            }
          }
        }
      }
    end

    let(:instance) do
      MilestoneResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true)
      }.to change { Milestone.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:milestone) { create(:milestone) }

    let(:payload) do
      {
        data: {
          id: milestone.id.to_s,
          type: 'milestones',
          attributes: { name: 'changed!' }
        }
      }
    end

    let(:instance) do
      MilestoneResource.find(payload)
    end

    it 'works' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { milestone.reload.updated_at }
       .and change { milestone.name }.to('changed!')
    end
  end

  describe 'destroying' do
    let!(:milestone) { create(:milestone) }

    let(:instance) do
      MilestoneResource.find(id: milestone.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Milestone.count }.by(-1)
    end
  end
end
