require 'rails_helper'

RSpec.describe "departments#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/departments", params: params
  end

  describe 'basic fetch' do
    let!(:department1) { create(:department) }
    let!(:department2) { create(:department) }

    it 'works' do
      expect(DepartmentResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.map(&:jsonapi_type).uniq).to match_array(['departments'])
      expect(d.map(&:id)).to match_array([department1.id, department2.id])
    end
  end
end
