class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :users, through: :favorites
  
  mount_uploader :image, ImageUploader
  
  validates :comment, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 100 }
end
