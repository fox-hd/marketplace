class User < ApplicationRecord
  belongs_to :company
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_company

  

  private
  def set_company
    return if company.present?
    domain_name = email.split('@')[1].split('.')[0].capitalize
    search_domain = Company.find_by(name: domain_name)
    if search_domain.blank?
      errors.add(:company, 'não está registrada')
    else
      self.company = search_domain
    end
  end

  
end
