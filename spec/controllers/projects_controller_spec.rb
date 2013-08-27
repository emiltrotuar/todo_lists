require 'spec_helper'

describe ProjectsController do
	describe "GET #index" do
		it "renders the index view" do
			project = FactoryGirl.create(:project)
			get :index
			response.should render_template 'sessions/new'
		end
	end

	describe "If user sign_in" do

   before(:all){ 
     @user = FactoryGirl.create(:user)
   }

   it "should get new" do
     sign_in @user  
     get 'new'
     response.should be_success
     response.should render_template('projects/new')
   end

   it "should create project" do
     sign_in @user
     project 'create', :project => FactoryGirl.create(:project)
     response.should redirect_to(project_path(:project))
   end
  end  
end