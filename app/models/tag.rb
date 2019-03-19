class Tag < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  
  has_many :code_tags
  has_many :codes, through: :code_tags, source: :code
end
