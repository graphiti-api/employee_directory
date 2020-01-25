require 'rails_helper'

RSpec.describe "employees#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/employees/#{employee.id}", payload
  end

  describe 'basic update' do
    let!(:employee) { create(:employee, age: 20) }

    let(:payload) do
      {
        data: {
          id: employee.id.to_s,
          type: 'employees',
          attributes: {
            first_name: 'updated firstname',
          }
        }
      }
    end

    it 'updates the resource' do
      expect(EmployeeResource).to receive(:find).and_call_original
      expect {
        make_request
      }.to change { employee.reload.attributes }
      expect(response.status).to eq(200)
    end
  end

  describe 'adding an invalid position when already pre-existing positions' do
    let!(:employee) { create(:employee, age: 20) }
    let!(:pos1) { create(:position, employee: employee) }

    let(:payload) do
      {
        data: {
          id: employee.id.to_s,
          type: 'employees',
          relationships: {
            positions: {
              data: [
                { type: 'positions', :'temp-id' => 'abc123', method: 'create' }
              ]
            }
          }
        },
        included: [
          {
            type: 'positions',
            :'temp-id' => 'abc123',
            attributes: {}
          }
        ]
      }
    end

    it 'works' do
      make_request
      binding.pry
    end
  end
end
