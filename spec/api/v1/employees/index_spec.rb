require 'rails_helper'

RSpec.describe "employees#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/employees", params: params
  end

  describe 'basic fetch' do
    let!(:employee1) { create(:employee) }
    let!(:employee2) { create(:employee) }

    it 'works' do
      expect(EmployeeResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.map(&:jsonapi_type).uniq).to match_array(['employees'])
      expect(d.map(&:id)).to match_array([employee1.id, employee2.id])
    end
  end
end
