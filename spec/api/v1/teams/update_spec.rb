require 'rails_helper'

RSpec.describe "teams#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/teams/#{team.id}", payload
  end

  describe 'basic update' do
    let!(:team) { create(:team) }

    let(:payload) do
      {
        data: {
          id: team.id.to_s,
          type: 'teams',
          attributes: {
            name: 'changed!'
          }
        }
      }
    end

    it 'updates the resource' do
      expect(TeamResource).to receive(:find).and_call_original
      expect {
        make_request
      }.to change { team.reload.attributes }
      expect(response.status).to eq(200)
    end
  end
end
