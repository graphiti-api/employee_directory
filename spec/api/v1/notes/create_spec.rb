require 'rails_helper'

RSpec.describe "notes#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/notes", payload
  end

  describe 'basic create' do
    let!(:department) { create(:department) }

    let(:payload) do
      {
        data: {
          type: 'notes',
          attributes: {
          },
          relationships: {
            notable: {
              data: {
                type: 'departments',
                id: department.id.to_s
              }
            }
          }
        }
      }
    end

    it 'works' do
      expect(NoteResource).to receive(:build).and_call_original
      expect {
        make_request
      }.to change { Note.count }.by(1)
      note = Note.last
      expect(response.status).to eq(201)
    end
  end
end
