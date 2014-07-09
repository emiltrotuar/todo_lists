class NotesController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  # GET /notes
  # GET /notes.json
  def index
    @notes = current_user.notes
    respond_with @notes
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = current_user.notes.create!(content: params[:note][:content])
    respond_with @note
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
   def destroy
    note = current_notes.find(params[:id])
    head :ok if note.delete
  end

  private

  def current_notes
    current_user.notes
  end
end
