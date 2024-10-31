class HomesController < ApplicationController
  def index
    #initializer
    current_company = current_user.company.token

    #products
    products = Product.where(company_id: current_company)
    @products_summary = {
      product_qty_stock: products.sum(:stock),
      product_qty_itens: products.count,
      product_value: products.sum('price * stock')
    }

    #sales
    @filter_date = Date.today
    @filter_date = Date.parse(params[:filter_date]) if params[:filter_date].present?

    sales_by_invoice = Sale.joins(:product)
                .where(company_id: current_company)
                .where('EXTRACT(YEAR FROM sales.updated_at) = ?', @filter_date.year)
                .where('EXTRACT(MONTH FROM sales.updated_at) = ?', @filter_date.month)
                .group(:invoice_id, :product_id, :sku)
                .select('
                  invoice_id,
                  sku,
                  MAX(description) AS description,
                  SUM(quantity) AS quantity,
                  SUM(sum_price) AS amount,
                  MAX(sales.updated_at) AS date
                ')
                .order('SUM(sum_price) DESC')
                .limit(3)

    sales_by_product = Sale.joins(:product)
                .where(company_id: current_company)
                .where('EXTRACT(YEAR FROM sales.updated_at) = ?', @filter_date.year)
                .where('EXTRACT(MONTH FROM sales.updated_at) = ?', @filter_date.month)
                .group(:product_id, :sku)
                .select('
                  sku,
                  MAX(description) AS description,
                  SUM(quantity) AS quantity,
                  SUM(sum_price) AS amount,
                  MAX(sales.updated_at) AS date
                ')
                .order('SUM(sum_price) DESC')
                .limit(3)

    @sales_summary = {
      top_day_by_invoice: sales_by_invoice.where('EXTRACT(DAY FROM sales.updated_at) = ?', @filter_date.day).order('SUM(sum_price) DESC').limit(3),
      top_month_by_invoice: sales_by_invoice,
      top_day_by_product:sales_by_product.where('EXTRACT(DAY FROM sales.updated_at) = ?', @filter_date.day).order('SUM(sum_price) DESC').limit(3),
      top_month_by_product: sales_by_product
    }

    #invoices
  end
end
