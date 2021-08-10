class Group < ApplicationRecord

  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }, presence:true
  validates :introduction, length: { maximum: 50 }

  attachment :group_image

  has_many :group_user
  has_many :users, through: :group_user

end
