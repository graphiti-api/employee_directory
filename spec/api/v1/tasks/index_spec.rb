require 'rails_helper'

RSpec.describe "tasks#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/tasks", params: params
  end

  describe 'basic fetch' do
    let!(:task1) { create(:bug) }
    let!(:task2) { create(:feature) }
    let!(:task3) { create(:epic) }

    it 'works' do
      expect(TaskResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.map(&:jsonapi_type).uniq)
        .to match_array(%w(bugs features epics))
      expect(d.map(&:id)).to match_array([task1.id, task2.id, task3.id])
    end
  end
end
