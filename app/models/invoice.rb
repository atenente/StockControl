class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :sales, dependent: :destroy

  validates :payment_method, :payment_local, :payment_split, presence: true
  validates_numericality_of :payment_split, greater_than: 0

  before_create :populate_values_on_invoice
  after_create :populate_invoice_on_sales

  private

  def populate_values_on_invoice
    sales = Sale.where(invoice_id: nil, user_id: user.id)
    self.total_quantity = sales.sum(:quantity)
    self.total_value = sales.sum(:sum_price)
    self.user_id = user.id
    self.company_id = self.user.company_id
  end

  def populate_invoice_on_sales
    Sale.where(invoice_id: nil, user_id: user.id).update_all(invoice_id: self.id)
  end
end
