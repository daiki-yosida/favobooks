class User < ApplicationRecord
  before_save { self.email.downcase! }
  has_secure_password
  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: { case_sensitive: false }
  
  has_many :books
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites
  has_many :favorite_books, through: :favorites, source: :book
  
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
 
  def add_favorite(other_book)
    unless self.books == other_book
      self.favorites.find_or_create_by(book_id: other_book.id)
    end
  end
  
  def unfavorite(other_book)
    favorite = self.favorites.find_by(book_id: other_book.id)
    favorite.destroy if favorite
  end
  
  def favorite?(other_book)
    self.favorite_books.include?(other_book)
  end
    
end
