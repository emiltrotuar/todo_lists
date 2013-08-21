require 'spec_helper'

describe Task do
  let(:project) { FactoryGirl.create(:project) }
  before { @task = project.tasks.build(content: "Lorem ipsum") }

  subject { @task }

  it { should respond_to(:content) }
  it { should respond_to(:project_id) }
  it { should respond_to(:project) }
  its(:project) { should == project }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to project_id" do
      expect do
        Task.new(project_id: project.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when project_id is not present" do
    before { @task.project_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @task.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @task.content = "a" * 101 }
    it { should_not be_valid }
  end
end
