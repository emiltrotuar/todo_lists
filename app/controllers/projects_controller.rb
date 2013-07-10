class ProjectsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def index
    if signed_in?
      @project = Project.find(1)
      @projects = current_user.projects
      @tasks = Project.find(1).tasks
    end
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.create!(params[:project])
    respond_to do |format|
      format.html {redirect_to projects_url}
      format.js
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes!(params[:project])
    respond_to do |format|
       format.html {redirect_to projects_url}
       format.js
     end
  end

  def destroy
    @project = Project.destroy(params[:id])
    respond_to do |format|
         format.html { redirect_to projects_url }
         format.js
    end
  end

   private

    def correct_user
      @project = current_user.projects.find_by_id(params[:id])
      redirect_to root_url if @project.nil?
    end
end
