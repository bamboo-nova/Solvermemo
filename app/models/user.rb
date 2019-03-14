class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :posts
  has_many :codes
  
  # フォロー、フォロワー
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationship, source: :user
  # 投稿お気に入り機能
  has_many :user_posts
  has_many :favorites, through: :user_posts, source: :post
  
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_posts
    Post.where(user_id: self.following_ids + [self.id])
  end
  
  def like(other_post)
    unless self == other_post
      self.user_posts.find_or_create_by(post_id: other_post.id)
    end
  end
  
  def unlike(other_post)
    user_post = self.user_posts.find_by(post_id: other_post.id)
    user_post.destroy if user_post
  end
  
  def liking?(other_post)
    self.favorites.include?(other_post)
  end
end
