class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :profiles
  has_many :products
end
