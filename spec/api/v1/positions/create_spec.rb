require 'rails_helper'

RSpec.describe "positions#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/positions", payload
  end

  describe 'basic create' do
    let!(:employee) { create(:employee) }
    let!(:department) { create(:department) }

    let(:payload) do
      {
        data: {
          type: 'positions',
          attributes: { },
          relationships: {
            employee: {
              data: {
                id: employee.id.to_s,
                type: 'employees'
              }
            },
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
      expect(PositionResource).to receive(:build).and_call_original
      expect {
        make_request
      }.to change { Position.count }.by(1)
      expect(response.status).to eq(201)
    end
  end
end
