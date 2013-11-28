class TasksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :find_task, only: [:edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = current_user.projects.find(params[:prj_id]).tasks.create!(params[:task])
    @task.move_to_bottom
    check_for_link
    respond_to do |format|
      format.html {redirect_to projects_url}
      format.js
    end
  end

  def update
    @task.update_attributes!(params[:task])
    check_for_link
    respond_to do |format|
       format.html { redirect_to projects_url }
       format.js
     end
  end

  def check_for_link
    link = @task.content.match(/https?:\/\/\w+\.\S*/)
    if link
      link =link.to_s
      @task.content.sub!(link, '<a href="'+link+'">'+link+'</a>')
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
         format.html { render nothing: true }
         format.js { render nothing: true }
    end
  end

  private

    def find_task
      @task = current_user.tasks.find(params[:id])
    end

end