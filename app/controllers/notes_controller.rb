class NotesController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
    respond_with @notes
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.create(content: params[:note][:content])
    respond_with @note
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
   def destroy
    note = Note.find(params[:id])
    head :ok if note.delete
  end
end
