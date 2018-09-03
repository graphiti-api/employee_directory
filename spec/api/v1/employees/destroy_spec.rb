require 'rails_helper'

RSpec.describe "employees#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/employees/#{employee.id}"
  end

  describe 'basic destroy' do
    let!(:employee) { create(:employee) }

    it 'updates the resource' do
      expect(EmployeeResource).to receive(:find).and_call_original
      expect { make_request }.to change { Employee.count }.by(-1)
      expect { employee.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(200)
      expect(json).to eq('meta' => {})
    end
  end
end
