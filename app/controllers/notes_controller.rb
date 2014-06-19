class NotesController < ApplicationController
  respond_to :json

  skip_before_action :verify_authenticity_token, only: :create

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

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end
end
