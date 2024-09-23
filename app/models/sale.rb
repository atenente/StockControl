class Sale < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :invoice, optional: true
  belongs_to :product

  validates :product_id, :quantity, presence: true
  validates_numericality_of :quantity, greater_than: 0

  before_save :populate_values_on_sale
  after_save :sum_values_on_invoice
  after_destroy :check_invoice_empty, :subtract_values_on_invoice

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

  def sum_values_on_invoice
    return unless Invoice.exists?(self.invoice_id)
    calculate_values_to_invoice(:+)
  end

  def subtract_values_on_invoice
    return unless Invoice.exists?(self.invoice_id)
    calculate_values_to_invoice(:-)
  end

  def calculate_values_to_invoice(operator)
    invoice = Invoice.find(self.invoice_id)
    binding.break
    new_total_quantity = invoice.total_quantity.send(operator, self.quantity)
    new_total_value = invoice.total_value.send(operator, self.sum_price)
    invoice.update(total_quantity: new_total_quantity, total_value: new_total_value)
  end
end
