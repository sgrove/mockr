require 'spec_helper'

describe User do

  describe "associations" do
    it "should have many mocks" do
      should have_many :mocks
    end

    it "should have many comments" do
      should have_many :comments
    end

    it "should have many discissions" do
      should have_many :discussions,
                       :class_name => "MockView",
                       :order => "last_replied_at DESC"
    end
  end

  describe "scopes" do
    it "should have active" do
      should have_scope :active
    end
  end

end

