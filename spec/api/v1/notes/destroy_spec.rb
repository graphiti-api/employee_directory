require 'rails_helper'

RSpec.describe "notes#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/notes/#{note.id}"
  end

  describe 'basic destroy' do
    let!(:note) { create(:employee_note) }

    it 'updates the resource' do
      expect(NoteResource).to receive(:find).and_call_original
      expect { make_request }.to change { Note.count }.by(-1)
      expect { note.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(response.status).to eq(200)
      expect(json).to eq('meta' => {})
    end
  end
end
