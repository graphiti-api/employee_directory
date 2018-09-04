require 'rails_helper'

RSpec.describe "tasks#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/tasks/#{task.id}"
  end

  describe 'basic destroy' do
    let!(:task) { create(:task) }

    it 'updates the resource' do
      expect(TaskResource).to receive(:find).and_call_original
      expect { make_request }.to change { Task.count }.by(-1)
      expect { task.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(200)
      expect(json).to eq('meta' => {})
    end
  end
end
