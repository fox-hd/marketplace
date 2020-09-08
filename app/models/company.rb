class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_many :products, dependent: :destroy

  before_create :name_domain

  private

  def name_domain
    self.name = email.split('@')[1].split('.')[0].capitalize
  end
end
