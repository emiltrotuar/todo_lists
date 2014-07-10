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
    array = params[:task]
    project = current_projects.find(params[:prj_id])
    tasks = project.tasks
    tasks.each do |task|
      set_position task, array
    end
    render nothing: true
  end

  def sortp
    array = params[:project]
    current_projects.each do |project|
      set_position project, array
    end
    render nothing: true
  end

  private

  def set_position item, array
    item.position = array.index(item.id.to_s)
    item.save
  end

  def current_projects
    current_user.projects
  end
end