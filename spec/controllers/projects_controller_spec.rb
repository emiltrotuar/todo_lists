require 'spec_helper'

describe ProjectsController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #index" do

  	it "renders the index view" do
  		project = FactoryGirl.create(:project)
  		get :index
  		response.should render_template 'index'
      response.code.should eq("200")
  	end

    it "loads all of the projects and tasks" do
      project1, project2 = @user.projects.create!(name: 'project1'), @user.projects.create!(name: 'project2')
      task1, task2 = project1.tasks.create!(content: 'task1'), project1.tasks.create!(content: 'task2')
      get :index
      expect(assigns(:projects)).to match_array([project1, project2])
      expect(assigns(:tasks)).to match_array([task1, task2])
    end

  end  

  describe "POST #create" do

    it "creates a new project" do
      expect{
        post :create, project: FactoryGirl.attributes_for(:project)
      }.to change(Project,:count).by(1)
    end

  end

  describe "PUT #update" do 

    before :each do 
      @project = FactoryGirl.create(:project, name: "project") 
    end 

    it "locates the requested @project" do 
      put :update, id: @project, project: FactoryGirl.attributes_for(:project) 
      assigns(:project).should eq(@project) 
    end 

    it "changes @project's attributes" do 
      put :update, id: @project, project: FactoryGirl.attributes_for(:project, name: "project") 
      @project.reload 
      @project.name.should eq("project") 
    end 

  end

  describe "DELETE #destroy" do

    it "deletes a project" do
      @project = @user.projects.create!(name: 'project')
      expect{
        delete :destroy, id: @project
      }.to change(Project,:count).by(-1)
    end

  end

end