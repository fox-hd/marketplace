class Product < ApplicationRecord
  belongs_to :profile
  belongs_to :company
end
