class Product < ApplicationRecord
  belongs_to :profile
  belongs_to :company
  has_many :comments, dependent: :destroy

  enum status: {available:0 , waiting: 10, sold:20}

  validates :name, :description, :price, :category, presence:true
  validates :price, numericality: {greater_than: 0}
  validates :name, length: {maximum: 30, message: 'São permitidos no maximo 30 caracteres'}
  validates :description, length: {maximum: 150, message: 'São permitidos no maximo 150 caracteres'}
end

