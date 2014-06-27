class UsersController < ApplicationController
  respond_to :json
  
  before_action :authenticate_user!, only: [:update, :me]

  def me
    respond_with current_user
  end

  def create
    @user = User.new(params.permit[:user])
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params.permit[:id])
    if @user.update_attributes(params.permit[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
end
