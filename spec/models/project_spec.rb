require 'spec_helper'

describe Project do
  let(:user) { FactoryGirl.create(:user) }
  before { @project = user.projects.build(name: "project") }

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Project.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @project.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @project.name = " " }
    it { should_not be_valid }
  end

  describe "with name that is too long" do
    before { @project.name = "a" * 76 }
    it { should_not be_valid }
  end
end
