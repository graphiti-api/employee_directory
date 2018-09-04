require 'rails_helper'

RSpec.describe "departments#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/departments/#{department.id}"
  end

  describe 'basic destroy' do
    let!(:department) { create(:department) }

    it 'updates the resource' do
      expect(DepartmentResource).to receive(:find).and_call_original
      expect { make_request }.to change { Department.count }.by(-1)
      expect { department.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(200)
      expect(json).to eq('meta' => {})
    end
  end
end
