class NotesController < ApplicationController
  def index
    notes = NoteResource.all(params)
    respond_with(notes)
  end

  def show
    note = NoteResource.find(params)
    respond_with(note)
  end

  def create
    note = NoteResource.build(params)

    if note.save
      render jsonapi: note, status: 201
    else
      render jsonapi_errors: note
    end
  end

  def update
    note = NoteResource.find(params)

    if note.update_attributes
      render jsonapi: note
    else
      render jsonapi_errors: note
    end
  end

  def destroy
    note = NoteResource.find(params)

    if note.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: note
    end
  end
end
