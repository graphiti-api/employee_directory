require 'rails_helper'

RSpec.describe "tasks#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/tasks", payload
  end

  describe 'basic create' do
    let(:payload) do
      {
        data: {
          type: 'bugs',
          attributes: {
          }
        }
      }
    end

    it 'works' do
      expect(TaskResource).to receive(:build).and_call_original
      expect {
        make_request
      }.to change { Bug.count }.by(1)
      expect(response.status).to eq(201)
    end
  end
end
