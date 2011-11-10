require 'spec_helper'
include Devise::TestHelpers


describe CommentsController do

  def valid_attributes
  end

  it "should use CommentsController" do
    controller.should be_an_instance_of(CommentsController)
  end

  describe "POST 'create'" do
    it "should redirect to mock path" do
      Notifier.stub!(:deliver_new_mock).and_return(true)
      login_user
      comment = Factory.build :comment
      controller.stub!(:current_user).and_return(User.first)
      post 'create', :comment => comment.attributes.stringify_keys!
      response.should redirect_to(mock_path(comment.mock))
    end
  end

  describe "DELETE 'destroy'" do
    it "should redirect to mock path" do
      Notifier.stub!(:deliver_new_mock).and_return(true)
      login_user
      comment = Factory :comment
      delete :destroy, :id => comment.id.to_s
      response.should redirect_to(mock_path comment.mock)
    end

    it "deletes the comment" do
      Notifier.stub!(:deliver_new_mock).and_return(true)
      comment = Factory :comment
      expect {
        login_user
        delete :destroy, :id => comment.id.to_s
      }.to change(Comment, :count).by(-1)
    end
  end

end
