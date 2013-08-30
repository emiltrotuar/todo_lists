require 'spec_helper'

describe UsersController do
	describe "User signed_in" do
		before(:each) do
			@user = FactoryGirl.create(:user)
			sign_in @user
    end

    it "should not allow non-logged users" do
      click_link "Sign out"
      get 'index'
      response.should redirect_to(root_path)
      flash[:alert].should eq('You should be logged in')
    end
  end
end