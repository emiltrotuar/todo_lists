class TasksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Project.find(params[:prj_id]).tasks.create!(params[:task])
    respond_to do |format|
      format.html {redirect_to tasks_url}
      format.js
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(params[:task])
    respond_to do |format|
       format.html {redirect_to projects_url}
       format.js
     end
  end

  def destroy
    @task = Task.find(params[:id]).destroy
    respond_to do |format|
         format.html { redirect_to projects_url }
         format.js
    end
  end
end
