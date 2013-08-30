require 'spec_helper'

describe ProjectsController do

  describe "User signed_in" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

		it "renders the index view" do
			project = FactoryGirl.create(:project)
			get :index
			response.should render_template 'index'
      response.code.should eq("200")
		end

    it "assigns @teams" do
      get :index
      assigns(:project).should be_a_new(Project)
    end

    it "should add project to list" do
      visit projects_path
      find(:css, "input[class=task_input]").set("testvalue")
      click_button("Add task")
      page.has_content?("testvalue")
      click_link "Sign out"
    end

    it "should get new project" do
      get new_project_path
      response.should be_success
      response.render_template(:partial => '_form')
      fill_in "project_name", width: "project"
    end

    it "should create project" do
       post 'create', FactoryGirl.create(:project)
       page.has_content?("project")
    end
  end  
end