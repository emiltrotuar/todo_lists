class ProjectsController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    respond_with current_projects
  end

  def create
    project = current_projects.create!(name: params[:project][:name])
    project.move_to :bottom
    respond_with project
  end

  def update
    project = current_projects.find(params[:id])
    project.update_attributes!(name: params[:project][:name])
    head :no_content
  end

  def destroy
    project = current_projects.find(params[:id])
    head :ok if project.delete
  end

  def sort
    project = current_projects.find(params[:prj_id])
    tasks = project.tasks
    tasks.each do |task|
      task.position = params['task'].index(task.id.to_s)
      task.save
    end
    render nothing: true
  end

  def sortp
    current_projects.each do |project|
      project.position = params['project'].index(project.id.to_s)
      project.save
    end
    render nothing: true
  end

  private

  def current_projects
    current_user.projects
  end
end