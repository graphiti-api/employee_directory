require 'rails_helper'

RSpec.describe "positions#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/positions/#{position.id}", params: params
  end

  describe 'basic fetch' do
    let!(:position) { create(:position) }

    it 'works' do
      expect(PositionResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(jsonapi_data.jsonapi_type).to eq('positions')
      expect(jsonapi_data.id).to eq(position.id)
    end
  end
end
