class UserCode < ApplicationRecord
  belongs_to :user
  belongs_to :code
  
  def self.ranking
    self.group(:code_id).order('count_code_id DESC').limit(10).count(:code_id)
  end
end
