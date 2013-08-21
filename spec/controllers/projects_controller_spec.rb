require 'spec_helper'

describe ProjectsController do
	describe "GET #index" do
		it "renders the index view" do
			project = FactoryGirl.create(:project)
			get :index
			response.should render_template :index
		end
	end
end