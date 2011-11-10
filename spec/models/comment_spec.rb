require 'spec_helper'

describe Comment do

  describe "associations" do
    it "should belong to author" do
      should belong_to :author, :class_name => "User"
    end

    it "should belong to mock" do
      should belong_to :mock
    end

    it "should belong to parent" do
      should belong_to :parent, :class_name => "Comment"
    end
    
    it "should have many children" do
      should have_many :children,
                       :class_name => "Comment",
                       :foreign_key => "parent_id"
    end
  end

  describe "scopes" do
    it "should have about" do
      mock = Factory :mock
      should have_scope(:about, :with=>mock).conditions({:mock_id=>mock.id})
    end

    it "should have by" do
      user = Factory :user
      should have_scope(:by, :with=>user).conditions({:author_id=>user.id})
    end

    it "should have in_reply_to" do
      should have_scope :in_reply_to
    end

    it "should have recent" do
      should have_scope :recent
    end

    it "should have since" do
      should have_scope :since
    end
  end

end
