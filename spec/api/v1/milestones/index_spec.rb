require 'rails_helper'

RSpec.describe "milestones#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/milestones", params: params
  end

  describe 'basic fetch' do
    let!(:milestone1) { create(:milestone) }
    let!(:milestone2) { create(:milestone) }

    it 'works' do
      expect(MilestoneResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.map(&:jsonapi_type).uniq).to match_array(['milestones'])
      expect(d.map(&:id)).to match_array([milestone1.id, milestone2.id])
    end
  end
end
