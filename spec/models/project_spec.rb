require 'spec_helper'

describe Project do
  before(:each) do
    @valid_attributes = {:title=>"Statue of Liberty"}
    @invalid_attributes = {}
  end

  describe "associations" do
    it "should have many MockLists" do
      should have_many :mock_lists
    end
  end

  describe "validations" do
    it "should validate uniqueness of title" do
      Project.create!(@valid_attributes)
      should validate_uniqueness_of :title
    end

    it "should validate presence of title" do
      should validate_presence_of :title
    end
  end

  describe "scopes" do
    it "should have alphabetical" do
      should have_scope :alphabetical
    end

    it "should have recently_updated" do
      should have_scope :recently_updated
    end
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
end
