class UsersController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def me
    respond_with current_user
  end
end
