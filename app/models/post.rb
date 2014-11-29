class Post < ActiveRecord::Base
  validates_presence_of :title, :body, :user_id
  validates_uniqueness_of :title
  validates_length_of :title, in: 5..140
  validates_length_of :body, minimum: 140

  belongs_to :user
  has_many :comments, dependent: :destroy
end
