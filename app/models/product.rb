class Product < ApplicationRecord
  belongs_to :profile
  belongs_to :company

  validates :name, :description, :price, :category, presence:true
  validates :price, numericality: {greater_than: 0}
end
