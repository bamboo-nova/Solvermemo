class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  
  mount_uploader :image, ImageUploader
  validates :content, presence: true, length: { maximum: 255 }
end
