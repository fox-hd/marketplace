class Product < ApplicationRecord
  belongs_to :profile
  belongs_to :company
  has_many :comments, dependent: :destroy
  has_one :order

  enum status: {enable:0 , disable: 10}

  validates :name, :description, :price, :category, presence:true
  validates :price, numericality: {greater_than: 0}
  validates :name, length: {maximum: 30, message: 'São permitidos no maximo 30 caracteres'}
  validates :description, length: {maximum: 150, message: 'São permitidos no maximo 150 caracteres'}
end

