class User < ActiveRecord::Base
  has_many :awards
  has_many :mocks, :foreign_key => :author_id
  has_many :comments, :foreign_key => :author_id
  has_many :discussions,
    :conditions => "reply_count > 0",
    :order      => "last_replied_at DESC",
    :class_name => "MockView"

  named_scope :active, :conditions => {:active => true}

  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # validates_uniqueness_of :facebook_uid
  validates_uniqueness_of :email

  def self.activate!(email, name)
    user = User.find_or_create_by_email(email)
    user.name = name
    user.active = true
    user.save
    user
  end

  def first_name
    name.to_s.split.first.to_s
  end

  def awarded_feelings
    self.awards.map(&:feeling)
  end

  def real?
    !self.id.nil?
  end

  def authorized?
    (real? && active?)
  end

  def authenticated?
    !self.email.blank?
  end

  # Returns the set of comments that the user is interested in tracking
  # new replies to.
  def subscribed_comment_ids(mock)
    comments = Comment.by(self).about(mock).all(:select => "id, parent_id")
    comments.map do |c|
      c.parent_id || c.id
    end
  end
end
