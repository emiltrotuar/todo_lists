class ProjectsController < ApplicationController
  respond_to :json
  # before_filter :signed_in_user, only: [:create, :destroy]
  # before_filter :correct_user,   only: :destroy

  def index
    projects = Project.all
    respond_with projects
  end

  def new
    @project = Project.new
  end

  def create
    project = Project.new(name: params[:project][:name])
    # project.move_to_bottom
    respond_with project if project.save
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])
    project.update_attributes!(name: params[:project][:name])
    head :no_content
  end

  def destroy
    project = Project.find(params[:id])
    head :ok if project.delete
  end

  def sort
    @project = Project.find(params[:prj_id])
    @tasks = @project.tasks
    @tasks.each do |task|
      task.position = params['task'].index(task.id.to_s) + 1
      task.save
    end
    render nothing: true
  end

  def sortp
    @projects = Project
    @projects.each do |project|
      project.position = params['project'].index(project.id.to_s) + 1
      project.save
    end
    render nothing: true
  end

  private

    def correct_user
      @project = current_projects.find_by_id(params[:id])
      redirect_to root_url if @project.nil?
    end

    def current_projects
      current_user.projects
    end

end