require 'rails_helper'

RSpec.describe "teams#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/teams/#{team.id}", params: params
  end

  describe 'basic fetch' do
    let!(:team) { create(:team) }

    it 'works' do
      expect(TeamResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('teams')
      expect(d.id).to eq(team.id)
    end
  end
end
