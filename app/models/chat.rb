class Chat < ApplicationRecord
  belongs_to :order
  belongs_to :profile

  validates :body, presence:true
end
