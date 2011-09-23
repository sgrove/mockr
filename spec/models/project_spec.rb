require 'spec_helper'

describe Project do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  describe "associations" do
    it "should have many MockLists" do
      should have_many :mock_lists
    end
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
end
