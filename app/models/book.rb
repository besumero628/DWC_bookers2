class Book < ApplicationRecord
  validates :title, :body, presence:true
  
  belongs_to :users
end
