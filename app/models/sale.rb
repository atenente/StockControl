class Sale < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :product
end
