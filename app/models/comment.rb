class Comment < ActiveRecord::Base

  has_many   :children, :class_name => 'Comment', :foreign_key => 'parent_id'
  belongs_to :author,   :class_name => "User"
  belongs_to :parent,   :class_name => 'Comment'
  belongs_to :mock,     :touch      => true

  named_scope :about,       lambda {|mock|      {:conditions => {:mock_id => mock.id     }}}
  named_scope :by,          lambda {|author|    {:conditions => {:author_id => author.id }}}
  named_scope :in_reply_to, lambda {|parent_id| {:conditions => {:parent_id => parent_id }}}
  named_scope :since,       lambda {|time|      {:conditions => ["created_at >= ?", time] }}
  named_scope :sad,                              :conditions => {:feeling => "sad"         }
  named_scope :happy,                            :conditions => {:feeling => "happy"       }
  named_scope :recent,                           :order      => "created_at DESC"

  validates_presence_of :author
  validates_presence_of :text, :if => Proc.new { |comment| comment.parent }
  validates_presence_of :feeling, :if => Proc.new { |comment| comment.parent.nil? && comment.text.blank? }

  attr_accessible :author_id, :parent_id, :text, :mock_id

  before_validation :truncate_text_if_necessary


  def siblings
    self.parent_id ? self.parent.children : []
  end

  def truncate_text_if_necessary
    max_comment_length = 2_000 
    self.text = self.text[0, max_comment_length]
  end

  def box_attribute
    "box=\"#{x}_#{y}_#{width}_#{height}\"" if x && y && width && height
  end

  def self.basic_feelings
    ["happy", "sad"]
  end

  def self.advanced_feelings
     self.feelings - self.basic_feelings
  end

  def self.feelings
    Dir.glob("public/images/feelings/*").map do |name|
      name.split("/").last.gsub(".gif", "")
    end
  end

  # A comment is fresh if it has a new child comment or it hasn't been viewed
  # yet.
  def fresh?(mock_viewed_at)
    if !mock_viewed_at
      true
    elsif self.children.any?
      self.children.last.created_at > mock_viewed_at
    else
      self.created_at > mock_viewed_at
    end
  end

  def recipient_emails
    self.subscriber_emails - [self.author.email]
  end

  def siblings
    self.parent_id ? (self.parent.children - [self]) : []
  end

  def subscriber_emails
    emails = []
    emails = ([self.parent] + self.siblings).collect(&:author).collect(&:email).uniq if self.parent_id
    emails += [self.mock.author.email].compact
  end

  def has_selection?
    parent.try(:has_selection?) or (x and y and width and height)
  end

  def selection_image
    return false unless self.has_selection?
    parent.try(:selection_image) or mock.subimage(x, y, width, height)
  end
end
