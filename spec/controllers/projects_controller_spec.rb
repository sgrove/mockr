require "spec_helper"
require 'factory_girl'

describe ProjectsController do

  def valid_attributes
    {"title" => "example project"}
  end

  def invalid_attributes
    {}
  end

  def mock_project(stubs={})
    @mock_project ||= mock_model(Project, stubs)
  end
  
  describe "GET new" do
    it "should be success" do
      get :new
      response.should be_success
    end
  end

  describe "POST create" do
    it "should create a new project" do
      expect {
        post :create, :project => valid_attributes
      }.to change(Project, :count).by(1)
    end

    it "should redirect to project_path" do
      post :create, :project => valid_attributes
      response.should redirect_to(project_path Project.last)
    end

    it "should render new action if project is invalid" do
      post :create, :project => invalid_attributes
      response.should render_template("new")
    end
  end

  describe "PUT update" do
    it "should update the project" do
      Project.stub(:find).with("42").and_return(mock_project)
      mock_project.should_receive(:update_attributes).with(valid_attributes)
      put :update, :id => "42", :project => valid_attributes
    end

    it "should redirect to project path" do
      project = Factory :project
      put :update, :id => project.id, :project => valid_attributes
      response.should redirect_to project_path(project.id)
    end
  end

  describe "GET show" do
    it "should find the project" do
      Project.should_receive(:find).with("42")
      get :show, :id => "42"
    end

    it "should assign project to @project" do
      Project.stub(:find).with("42").and_return(mock_project)
      get :show, :id => "42"
      assigns(:project).should equal(mock_project)
    end
  end

end
