class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy#, foreign_key => "book_id"
  has_many :book_comments, dependent: :destroy
  is_impressionable
  
  validates :title, presence:true
  validates :body, length: { maximum: 200 },presence:true
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
  

  def favorites_count
    Favorite.where(book_id: id).count
  end

  def favorited?(user_id)
    Favorite.exists?(user_id: user_id, book_id: id) ? true : false
  end

  def book_comments_count
    BookComment.where(book_id: id).count
  end

end
