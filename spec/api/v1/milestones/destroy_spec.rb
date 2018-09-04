require 'rails_helper'

RSpec.describe "milestones#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/milestones/#{milestone.id}"
  end

  describe 'basic destroy' do
    let!(:milestone) { create(:milestone) }

    it 'updates the resource' do
      expect(MilestoneResource).to receive(:find).and_call_original
      expect { make_request }.to change { Milestone.count }.by(-1)
      expect { milestone.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(200)
      expect(json).to eq('meta' => {})
    end
  end
end
