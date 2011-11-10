require 'spec_helper'

describe CollaboratorsController do

  it "should use CollaboratorsController" do
    controller.should be_an_instance_of(CollaboratorsController)
  end

  describe "POST 'create'" do
    it "should redirect to collaborators path" do
      post 'create'
      response.should redirect_to collaborators_path
    end
  end

  describe "GET 'destroy'" do
    it "should redirect to collaborators path" do
      collaborator = Factory :user
      delete :destroy, :id => collaborator.id.to_s
      response.should redirect_to collaborators_path
    end

    it "deletes the requested collaborator" do
      collaborator = Factory :user
      expect {
        delete :destroy, :id => collaborator.id.to_s
      }.to change(User, :count).by(-1)
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end
