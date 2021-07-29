class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }, presence:true
  validates :introduction, length: { maximum: 50 }

  attachment :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :follower, class_name:"Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :all_follower, through: :follower, source: :followed

  has_many :followed, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :all_followed, through: :followed, source: :follower


  def follower?(current_user_id)
    Relationship.exists?(follower_id: current_user_id, followed_id: id) ? true : false
  end

end
