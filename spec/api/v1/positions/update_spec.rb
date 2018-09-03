require 'rails_helper'

RSpec.describe "positions#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/positions/#{position.id}", payload
  end

  describe 'basic update' do
    let!(:position) { create(:position) }

    let(:payload) do
      {
        data: {
          id: position.id.to_s,
          type: 'positions',
          attributes: {
            title: 'changed!'
          }
        }
      }
    end

    it 'updates the resource' do
      expect(PositionResource).to receive(:find).and_call_original
      expect {
        make_request
      }.to change { position.reload.attributes }
      expect(response.status).to eq(200)
    end
  end
end
