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
end
