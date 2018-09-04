require 'rails_helper'

RSpec.describe "teams#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/teams", payload
  end

  describe 'basic create' do
    let!(:department) { create(:department) }

    let(:payload) do
      {
        data: {
          type: 'teams',
          attributes: {
          },
          relationships: {
            department: {
              data: {
                id: department.id.to_s,
                type: 'departments'
              }
            }
          }
        }
      }
    end

    it 'works' do
      expect(TeamResource).to receive(:build).and_call_original
      expect {
        make_request
      }.to change { Team.count }.by(1)
      team = Team.last
      expect(response.status).to eq(201)
    end
  end
end
