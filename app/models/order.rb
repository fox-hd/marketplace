class Order < ApplicationRecord
  belongs_to :profile
  belongs_to :product
  has_many :chats

  enum status: {waiting:0, accept: 10, decline: 20}
end
