require 'spec_helper'

describe "Users" do

	subject { page }

	describe "Show" do

		it "should have the content 'SIMPLE TODO LISTS'" do
			visit show_path
			page.should have_content('SIMPLE TODO LISTS')
		end
		it "should have the table" do
			visit show_path
			page.should have_selector('table')
		end
	end
	describe "Edit" do

		it "should have the form tag" do
			visit edit_path
			page.should have_selector('form')
		end
		
	end
end