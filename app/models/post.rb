class Post < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :summary, presence: true, length: { maximum: 100 }
  mount_uploader :image, ImageUploader
  #serialize :image, JSON
end
