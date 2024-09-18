class Sale < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :invoice, optional: true
  belongs_to :product

  validates :product_id, :quantity, presence: true
  validates_numericality_of :quantity, greater_than: 0
end
