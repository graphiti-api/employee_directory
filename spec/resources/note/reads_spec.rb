require 'rails_helper'

RSpec.describe NoteResource, type: :resource do
  describe 'serialization' do
    let!(:note) { create(:employee_note, body: 'body!') }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(note.id)
      expect(data.jsonapi_type).to eq('notes')
      expect(data.body).to eq('body!')
    end
  end

  describe 'filtering' do
    let!(:note1) { create(:department_note) }
    let!(:note2) { create(:employee_note) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: note2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([note2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:note1) { create(:department_note) }
      let!(:note2) { create(:employee_note) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            note1.id,
            note2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            note2.id,
            note1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
