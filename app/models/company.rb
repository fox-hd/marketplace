class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :profiles, dependent: :destroy
  has_many :products, dependent: :destroy
end
