class SalesController < ApplicationController
  before_action :find_sale, only: [:show, :edit, :update, :destroy]
  before_action :load_variables, only: [:index ,:new, :create]

  def index
    return find_sales if params[:filter_value].present?
    @sales = current_user.company.sales.where.not(invoice_id: nil).order(invoice_id: :desc)
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = current_user.company.sales.build(sale_params)
    @sale.user_id = current_user.id
    unless @sale.product_id.nil?
      product = Product.find(@sale.product_id)
      @sale.price = product.price
      @sale.sum_price = (product.price.to_f * @sale.quantity)
    end

    if @sale.save
      redirect_to new_sale_path, notice: t('messages.success')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    return redirect_to sale_path(@sale) if @sale.update(sale_params)

    render :edit
  end

  def destroy
    @sale.destroy

    redirect_to new_sale_path
  end

  private

  def load_variables
    @invoice = Invoice.new
    @products = current_user.company.products
    @sales = current_user.company.sales.where(invoice_id: nil, user_id: current_user.id)
  end

  def sale_params
    params.require(:sale).permit(:product_id, :quantity)
  end

  def find_sale
    @sale = current_user.company.sales.find(params[:id])
  rescue
    redirect_to root_path, alert: t('messages.not_found')
  end

  def find_sales
    column = params[:filter_column]
    value = params[:filter_value]
    if %w[stock price].include?(column)
      @sales = Sale.where("company_id = ? AND #{column} = ?", current_user.company_id, value.to_f)
    else
      @sales = Sale.where("company_id = ? AND #{column} LIKE ?", current_user.company_id,"%#{value}%")
    end
  end

end
