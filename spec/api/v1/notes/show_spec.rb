require 'rails_helper'

RSpec.describe "notes#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/notes/#{note.id}", params: params
  end

  describe 'basic fetch' do
    let!(:note) { create(:employee_note) }

    it 'works' do
      expect(NoteResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(jsonapi_data.jsonapi_type).to eq('notes')
      expect(jsonapi_data.id).to eq(note.id)
    end
  end
end
