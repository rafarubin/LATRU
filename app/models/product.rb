class Product < ApplicationRecord
  has_many :historicals
  has_one_attached :photo
end
