class Product < ApplicationRecord
  before_validation :set_default_price
  validates :sku, presence: true
  validates :price, numericality: true
  validates :stock, :sku, numericality: { only_integer: true }

  private

  def set_default_price
    self.price = price.to_s.tr(',', '.').to_f if price.present?
  end
end
