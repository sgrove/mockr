require 'spec_helper'

describe Mock do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  describe "associations" do
    it "should have many comments" do
      should have_many :comments
    end

    it "should belong to author" do
      should belong_to :author
    end

    it "should belong to mock list" do
      should belong_to :mock_list
    end
  end

  describe "validations" do
    it "should validate presence of author" do
      should validate_presence_of :author
    end
  end

  describe "scopes" do
    # it "should have recent" do
    #  should have_scope :recent
    # end

    it "should have with_author_and_project_data" do
      should have_scope :with_author_and_project_data
    end
  end

  it "should create a new instance given valid attributes" do
    Mock.create!(@valid_attributes)
  end
end
