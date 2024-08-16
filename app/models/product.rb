class Product < ApplicationRecord
  belongs_to :company, foreign_key: 'company_id', foreign_key: 'company_id'

  before_validation :set_default_price

  validates :sku, presence: true
  validates :sku, uniqueness: { scope: :company_id }
  validates :price, numericality: true
  validates :stock, numericality: { only_integer: true }
  validates :description, length: { maximum: 255 }

  private

  def set_default_price
    self.price = price.to_s.tr(',', '.').to_f if price.present?
  end
end
