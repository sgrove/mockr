require 'spec_helper'
include Devise::TestHelpers

describe MocksController do

  before :each do
    login_user
  end

  def mock_mock(stubs={})
    @mock_mock ||= mock_model Mock, stubs
  end
  
  describe "GET new" do
    it "should render fine" do
      get :new
      response.should be_success
    end
  end

  describe "GET index" do
    it "should get all mocks" do
      Mock.should_receive(:all)
      get :index
    end

    it "should assign mocks to @mocks" do
      Mock.should_receive(:all).and_return([mock_mock])
      get :index
      assigns(:mocks).should == [mock_mock]
    end
  end

  describe "GET edit" do
    it "should call Mock#find" do
      Mock.should_receive(:find).with("42")
      get :edit, :id => "42"
    end

    it "should assigns to @mock" do
      Mock.stub(:find).with("42").and_return(mock_mock)
      get :edit, :id => "42"
      assigns(:mock).should equal(mock_mock)
    end
  end

  describe "POST create" do
  end

  describe "GET show" do
  end
    
  describe "PUT update" do
  end

  describe "DELETE destroy" do
  end

end
