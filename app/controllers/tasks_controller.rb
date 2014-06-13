class TasksController < ApplicationController
  respond_to :json
  # before_filter :signed_in_user, only: [:create, :destroy]
  # before_filter :find_task, only: [:edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    # @task = current_user.projects.find(params[:prj_id]).tasks.create!(params[:task])
    project = Project.find(params[:task][:project])
    task = project.tasks.create!(name: params[:task][:name])
    # task.move_to_bottom
    # check_for_link
    respond_with task
  end

  def update
    # project = Project.find(params[:task][:project])
    task = Task.find(params[:id])
    task.update_attributes!(name: params[:task][:name])
    head :no_content # check if it really saved!
  end

  def check_for_link
    link = @task.name.match(/https?:\/\/\w+\.\S*/)
    if link
      link =link.to_s
      @task.name.sub!(link, '<a href="'+link+'">'+link+'</a>')
    end
  end

  def destroy
    task = Task.find(params[:id])
    head :ok if task.delete
  end

  private

    def find_task
      @task = current_user.tasks.find(params[:id])
    end

end