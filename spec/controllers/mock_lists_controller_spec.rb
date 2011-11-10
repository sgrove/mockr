require 'spec_helper'

describe MockListsController do

  def valid_attributes
    {"title" => "a mock list", "project_id"=>1}
  end

  def mock_mocklist(stubs={})
    @mock_mocklist ||= mock_model(MockList, stubs)
  end

  describe "PUT update" do
    it "should update the mocklist" do
      MockList.should_receive(:find).with("42").and_return(mock_mocklist)
      mock_mocklist.should_receive(:update_attributes).with(valid_attributes)
      mock_mocklist.should_receive(:project_id).and_return("1")
      put :update, :id=>"42", :mock_list=>valid_attributes
    end

    it "should redirect to project path" do
      mocklist = Factory :mock_list
      put :update, :id => mocklist.id, :mock_list => valid_attributes
      response.should redirect_to(project_path mocklist.project_id)
    end
  end

end
