class SalesController < ApplicationController
  before_action :load_variables, only: [:index ,:new, :create, :edit]
  before_action :find_sale, only: [:destroy]

  def index
    return find_sales if params[:filter_value].present?
    @sales = current_user.company.sales.where.not(invoice_id: nil).order(invoice_id: :desc)
  end

  def new
    load_sales
    load_sale
  end

  def create
    load_sales
    load_sale(sale_params)
    @sale.user_id = current_user.id
    invoice_id = params[:sale][:invoice_id].to_i

    if @sale.save
      return redirect_to edit_sale_path(invoice_id), notice: t('messages.success') if !invoice_id.zero?
      redirect_to new_sale_path, notice: t('messages.success')
    else
      return redirect_to edit_sale_path(invoice_id), alert: t('messages.failure') if !invoice_id.zero?
      render :new
    end
  end

  def edit
    load_sales(params[:id])
    load_sale
    unless @sales.present?
      redirect_to sales_path
    end
  end

  def destroy
    @sale.destroy
    redirect_back(fallback_location: sales_path, notice: t('messages.destroy_success'))
  end

  private

  def load_variables
    @invoice = Invoice.new
    @products = current_user.company.products
  end

  def load_sales(invoice = nil, user = current_user.id)
    if invoice
      @sales = current_user.company.sales.where(invoice_id: invoice)
    else
      @sales = current_user.company.sales.where(invoice_id: invoice, user_id: user)
    end
  end

  def load_sale(sale_params = nil)
    @sale = current_user.company.sales.build(sale_params)
  end

  def sale_params
    params.require(:sale).permit(:product_id, :quantity, :invoice_id)
  end

  def find_sale
    @sale = current_user.company.sales.find(params[:id])
  rescue
    redirect_to root_path, alert: t('messages.not_found')
  end

  def find_sales
    column = params[:filter_column]
    value = params[:filter_value]

    @sales = Poros::Search.call(target_class: Sales, company_id:, column:, value:)
  end

end
