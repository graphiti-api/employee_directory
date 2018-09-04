require 'rails_helper'

RSpec.describe NoteResource, type: :resource do
  describe 'creating' do
    let!(:employee) { create(:employee) }

    let(:payload) do
      {
        data: {
          type: 'notes',
          attributes: { },
          relationships: {
            notable: {
              data: {
                type: 'employees',
                id: employee.id
              }
            }
          }
        }
      }
    end

    let(:instance) do
      NoteResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true)
      }.to change { Note.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:note) { create(:team_note) }

    let(:payload) do
      {
        data: {
          id: note.id.to_s,
          type: 'notes',
          attributes: { body: 'changed!' }
        }
      }
    end

    let(:instance) do
      NoteResource.find(payload)
    end

    it 'works' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { note.reload.updated_at }
       .and change { note.body }.to('changed!')
    end
  end

  describe 'destroying' do
    let!(:note) { create(:team_note) }

    let(:instance) do
      NoteResource.find(id: note.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Note.count }.by(-1)
    end
  end
end
