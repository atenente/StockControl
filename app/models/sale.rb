class Sale < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :invoice, optional: true
  belongs_to :product

  validates :product_id, :quantity, presence: true
  validates_numericality_of :quantity, greater_than: 0

  before_save :populate_values_on_sale
  after_destroy :check_invoice_empty

  private

  def populate_values_on_sale
    unless self.product_id.nil?
      product = Product.find(self.product_id)
      self.price = product.price
      self.sum_price = (product.price.to_f * self.quantity)
    end
  end

  def check_invoice_empty
    if Invoice.exists?(self.invoice_id) && !Sale.exists?(invoice_id: self.invoice_id)
      Invoice.find(self.invoice_id).destroy
    end
  end
end
