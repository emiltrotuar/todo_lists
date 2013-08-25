class ProjectsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def index
    if signed_in?
      @projects = current_user.projects
      @tasks = Task.all
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
    @project.move_to_bottom
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
     format.html { render nothing: true }
     format.js { render nothing: true }
    end
  end

  def sort
    @project = current_user.projects.find(params[:prj_id])
    @tasks = @project.tasks
    @tasks.each do |task|
      task.position = params['task'].index(task.id.to_s) + 1
      task.save
    end
    render nothing: true
  end

  def sortp
    @projects = current_user.projects
    @projects.each do |project|
      project.position = params['project'].index(project.id.to_s) + 1
      project.save
    end
    render nothing: true
  end

  private

    def correct_user
      @project = current_user.projects.find_by_id(params[:id])
      redirect_to root_url if @project.nil?
    end

end
