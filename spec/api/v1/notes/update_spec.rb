require 'rails_helper'

RSpec.describe "notes#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/notes/#{note.id}", payload
  end

  describe 'basic update' do
    let!(:note) { create(:department_note) }

    let(:payload) do
      {
        data: {
          id: note.id.to_s,
          type: 'notes',
          attributes: {
            body: 'changed!'
          }
        }
      }
    end

    it 'updates the resource' do
      expect(NoteResource).to receive(:find).and_call_original
      expect {
        make_request
      }.to change { note.reload.attributes }
      expect(response.status).to eq(200)
    end
  end
end
