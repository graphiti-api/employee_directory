require 'rails_helper'

RSpec.describe "teams#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/teams", params: params
  end

  describe 'basic fetch' do
    let!(:team1) { create(:team) }
    let!(:team2) { create(:team) }

    it 'works' do
      expect(TeamResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(jsonapi_data.map(&:jsonapi_type).uniq).to match_array(['teams'])
      expect(jsonapi_data.map(&:id)).to match_array([team1.id, team2.id])
    end
  end
end
