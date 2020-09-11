class Profile < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :comments , dependent: :destroy
  has_many :order
  has_many :chats

  validates :name, :nick_name, :date_of_birth, 
            :department, :role, :cpf, presence: true
  validates :name, :nick_name, :department, :role,
             length: {maximum: 30, message: 'São permitidos no maximo 30 caracteres'}
  validates :cpf, uniqueness: true
  validate :cpf_valid

  def cpf_valid
    if cpf.present? && !CPF.valid?(cpf)
      errors.add(:cpf, 'não é válido')
    end
  end
end
