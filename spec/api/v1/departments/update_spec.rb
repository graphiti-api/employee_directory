require 'rails_helper'

RSpec.describe "departments#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/departments/#{department.id}", payload
  end

  describe 'basic update' do
    let!(:department) { create(:department) }

    let(:payload) do
      {
        data: {
          id: department.id.to_s,
          type: 'departments',
          attributes: {
            name: 'changed!'
          }
        }
      }
    end

    it 'updates the resource' do
      expect(DepartmentResource).to receive(:find).and_call_original
      expect {
        make_request
      }.to change { department.reload.attributes }
      expect(response.status).to eq(200)
    end
  end
end
