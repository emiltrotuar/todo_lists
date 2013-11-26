class TasksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Project.find(params[:prj_id]).tasks.create!(params[:task])
    @task.move_to_bottom
    check_for_link
    respond_to do |format|
      format.html {redirect_to projects_url}
      format.js
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id]).destroy
    respond_to do |format|
         format.html { render nothing: true }
         format.js { render nothing: true }
    end
  end
end
