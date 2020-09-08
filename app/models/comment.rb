class Comment < ApplicationRecord
  belongs_to :profile
  belongs_to :product
  has_many :answers
end
