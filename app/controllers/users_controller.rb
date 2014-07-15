class UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def me
    add_csrf_to_headers
    respond_with current_user
  end
end
