class ProjectsController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  def index
    projects = current_user.projects
    respond_with projects
  end

  def create
    project = Project.new(name: params[:project][:name])
    project.move_to :bottom
    respond_with project if project.save
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
      task.position = params['task'].index(task.id.to_s)
      task.save
    end
    render nothing: true
  end

  def sortp
    @projects = Project.all
    @projects.each do |project|
      project.position = params['project'].index(project.id.to_s)
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