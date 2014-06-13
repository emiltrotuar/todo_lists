class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def show
    if signed_in?
      @user = User.find(params.permit[:id])
      @projects = @user.projects
      if @user == current_user
        render 'projects/index'
      else 
        render 'denied'
      end
    else
      flash[:alert] = "You should be logged in"
      render 'sessions/new'
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params.permit[:id])
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

  def destroy
    User.find(params.permit[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def correct_user
      @user = User.find(params.permit[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
