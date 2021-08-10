class Event < ApplicationRecord
  validates :subject, :message, presence:true
end
