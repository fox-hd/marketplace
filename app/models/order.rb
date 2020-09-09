class Order < ApplicationRecord
  belongs_to :profile
  belongs_to :product

  enum status: {waiting:0, accept: 10, decline: 20}
end
