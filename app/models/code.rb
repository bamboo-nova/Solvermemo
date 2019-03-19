class Code < ApplicationRecord
  belongs_to :user
  has_many :user_codes
  
  validates :content, presence: true, length: { maximum: 511 }
  validates :summary, presence: true, length: { maximum: 50 }
  mount_uploader :data, DataUploader
end
