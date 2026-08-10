require 'rails_helper'

RSpec.describe "employees#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/employees/#{employee.id}", params: params
  end

  describe 'basic fetch' do
    let!(:employee) { create(:employee) }

    it 'works' do
      expect(EmployeeResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(jsonapi_data.jsonapi_type).to eq('employees')
      expect(jsonapi_data.id).to eq(employee.id)
    end
  end
end
