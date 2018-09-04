require 'rails_helper'

RSpec.describe "teams#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/teams/#{team.id}"
  end

  describe 'basic destroy' do
    let!(:team) { create(:team) }

    it 'updates the resource' do
      expect(TeamResource).to receive(:find).and_call_original
      expect { make_request }.to change { Team.count }.by(-1)
      expect { team.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(200)
      expect(json).to eq('meta' => {})
    end
  end
end
