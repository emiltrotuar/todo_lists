class TasksController < ApplicationController
  respond_to :json
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    project = current_user.projects.find(params[:task][:project])
    task = project.tasks.create!(name: params[:task][:name])
    task.move_to :bottom
    respond_with task
  end

  def update
    return unless user_signed_in?
    task = Task.find(params[:id])
    task.update_attributes!(name: params[:task][:name],
                            done: params[:task][:done])
    head :no_content
  end

  def destroy
    return unless user_signed_in?
    task = Task.find(params[:id])
    head :ok if task.delete
  end
end