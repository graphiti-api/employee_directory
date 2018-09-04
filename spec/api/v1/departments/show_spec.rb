require 'rails_helper'

RSpec.describe "departments#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/departments/#{department.id}", params: params
  end

  describe 'basic fetch' do
    let!(:department) { create(:department) }

    it 'works' do
      expect(DepartmentResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('departments')
      expect(d.id).to eq(department.id)
    end
  end
end
