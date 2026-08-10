require 'rails_helper'

RSpec.describe "milestones#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/milestones/#{milestone.id}", params: params
  end

  describe 'basic fetch' do
    let!(:milestone) { create(:milestone) }

    it 'works' do
      expect(MilestoneResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(jsonapi_data.jsonapi_type).to eq('milestones')
      expect(jsonapi_data.id).to eq(milestone.id)
    end
  end
end
