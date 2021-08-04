class DirectMessage < ApplicationRecord
  belongs_to :send_user, class_name: "User"
  belongs_to :receive_user, class_name: "User"
  
  validates :send_user_id, :receive_user_id, :message, presence:true
end
