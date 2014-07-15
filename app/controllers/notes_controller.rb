class NotesController < ApplicationController
  respond_to :json
  before_action :authenticate_user!, except: :create
  before_action :authenticate_user_from_token!, only: :create
  skip_before_action :verify_authenticity_token

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
    headers['X-TL-Token'] = current_user.reset_extension_token
    env['rack.session.options'][:skip] = true
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

  def authenticate_user_from_token!
    token = request.headers['X-TL-Token']
    user = token && User.find_by(extension_token: token.to_s)

    if user
      sign_in user, store: false
    end
  end
end
