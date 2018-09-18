require 'rails_helper'

RSpec.describe "employees#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/employees", payload
  end

  describe 'basic create' do
    let(:payload) do
      {
        data: {
          type: 'employees',
          attributes: attributes_for(:employee)
        }
      }
    end

    it 'works' do
      expect(EmployeeResource).to receive(:build).and_call_original
      expect {
        make_request
      }.to change { Employee.count }.by(1)
      expect(response.status).to eq(201)
    end
  end
end
