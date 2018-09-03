require 'rails_helper'

RSpec.describe "positions#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/positions", params: params
  end

  describe 'basic fetch' do
    let!(:position1) { create(:position) }
    let!(:position2) { create(:position) }

    it 'works' do
      expect(PositionResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.map(&:jsonapi_type).uniq).to match_array(['positions'])
      expect(d.map(&:id)).to match_array([position1.id, position2.id])
    end
  end
end
