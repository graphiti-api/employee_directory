require 'rails_helper'

RSpec.describe "tasks#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/tasks/#{task.id}", params: params
  end

  describe 'basic fetch' do
    let!(:task) { create(:feature) }

    it 'works' do
      expect(TaskResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('features')
      expect(d.id).to eq(task.id)
    end
  end
end
