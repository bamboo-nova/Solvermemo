class Post < ApplicationRecord
  belongs_to :user
  has_many :user_posts
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :summary, presence: true, length: { maximum: 100 }
  mount_uploader :image, ImageUploader
  #serialize :image, JSON
end
