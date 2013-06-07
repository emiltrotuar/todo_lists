class TasksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def index
  end

  def create
    debugger
    @task = current_user.tasks.build(params[:task])
    if @task.save
      flash[:success] = "Task created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
    @task = Task.find(params["id"])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:success] = "Task updated"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @task.destroy
    redirect_to root_url
  end

   private

    def correct_user
      @task = current_user.tasks.find_by_id(params[:id])
      redirect_to root_url if @task.nil?
    end
end
