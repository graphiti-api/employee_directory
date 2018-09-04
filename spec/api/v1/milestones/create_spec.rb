require 'rails_helper'

RSpec.describe "milestones#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/milestones", payload
  end

  describe 'basic create' do
    let!(:epic) { create(:epic) }

    let(:payload) do
      {
        data: {
          type: 'milestones',
          attributes: {
          },
          relationships: {
            epic: {
              data: {
                id: epic.id.to_s,
                type: 'epics'
              }
            }
          }
        }
      }
    end

    it 'works' do
      expect(MilestoneResource).to receive(:build).and_call_original
      expect {
        make_request
      }.to change { Milestone.count }.by(1)
      milestone = Milestone.last
      expect(response.status).to eq(201)
    end
  end
end
