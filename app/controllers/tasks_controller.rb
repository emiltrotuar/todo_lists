class TasksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def index
    if signed_in?
      @incomplete_tasks = current_user.tasks.where(complete: false)
      @complete_tasks = current_user.tasks.where(complete: true)
    end
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.create!(params[:task])
    respond_to do |format|
      format.html {redirect_to tasks_url}
      format.js
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(params[:task])
    respond_to do |format|
       format.html {redirect_to tasks_url}
       format.js
     end
  end

  def destroy
    @task = Task.destroy(params[:id])
    respond_to do |format|
         format.html { redirect_to tasks_url }
         format.js
    end
  end

   private

    def correct_user
      @task = current_user.tasks.find_by_id(params[:id])
      redirect_to root_url if @task.nil?
    end
end
