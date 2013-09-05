require 'spec_helper'

describe TasksController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    sign_in @user
  end

  describe "PUT #update" do 

    before :each do 
      @task = FactoryGirl.create(:task, content: "task") 
    end 

    it "locates the requested @task" do 
      put :update, id: @task, task: FactoryGirl.attributes_for(:task) 
      assigns(:task).should eq(@task) 
    end 

    it "changes @task's attributes" do 
      put :update, id: @task, task: FactoryGirl.attributes_for(:task, content: "task") 
      @task.reload 
      @task.content.should eq("task") 
    end 

  end

  describe "DELETE #destroy" do

    it "deletes a task" do
      @task = @project.tasks.create!(content: 'task')
      expect{
        delete :destroy, id: @task
      }.to change(Task,:count).by(-1)
    end

  end

end