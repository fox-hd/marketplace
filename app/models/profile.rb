class Profile < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :products

  validates :name, :nick_name, :date_of_birth, 
            :department, :role, :cpf, presence: true
  validates :name, :nick_name, :department, :role,
             length: {maximum: 30, message: 'São permitidos no maximo 30 caracteres'}
             
end
