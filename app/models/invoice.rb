class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :sales

  validates :payment_method, :payment_local, :total_quantity, presence: true
  validates_numericality_of :total_value, :total_quantity, greater_than: 0
end
