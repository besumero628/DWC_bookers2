class Book < ApplicationRecord
  validates :title, presence:true
  validates :body, length: { maximum: 200 },presence:true

  belongs_to :user
  has_many :favorites, dependent: :destroy#, foreign_key => "book_id"

  def favorites_count
    Favorite.where(book_id: id).count
  end
  
  def favorited?(user_id)
    Favorite.exists?(user_id: user_id, book_id: id) ? true : false
  end
  
end
