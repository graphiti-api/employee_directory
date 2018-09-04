require 'rails_helper'

RSpec.describe "milestones#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/milestones/#{milestone.id}", payload
  end

  describe 'basic update' do
    let!(:milestone) { create(:milestone) }

    let(:payload) do
      {
        data: {
          id: milestone.id.to_s,
          type: 'milestones',
          attributes: {
            name: 'changed!'
          }
        }
      }
    end

    it 'updates the resource' do
      expect(MilestoneResource).to receive(:find).and_call_original
      expect {
        make_request
      }.to change { milestone.reload.attributes }
      expect(response.status).to eq(200)
    end
  end
end
