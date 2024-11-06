class Post < ApplicationRecord
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :cart_items
  validates :title, presence: true, length: {minimum: 5} 
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :image, presence: true
end
