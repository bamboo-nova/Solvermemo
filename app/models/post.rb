class Post < ApplicationRecord
  belongs_to :user
  has_many :user_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, class_name: Comment, foreign_key: :reply_comment, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :summary, presence: true, length: { maximum: 100 }
  mount_uploader :image, ImageUploader
  #serialize :image, JSON
end
