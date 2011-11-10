require 'spec_helper'

describe MockList do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  describe "associations" do
    it "should have many mocks" do
      should have_many :mocks
    end

    it "should belong to project" do
      should belong_to :project
    end
  end

  it "should create a new instance given valid attributes" do
    MockList.create!(@valid_attributes)
  end
end
