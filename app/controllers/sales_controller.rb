class SalesController < ApplicationController
  before_action :find_sale, only: [:show, :edit, :update, :destroy]

  def index
    return find_sales if params[:filter_value].present?
    @sales = current_user.company.sales
  end

  def new
    @sale = current_user.company.sales.build
  end

  def create

    @sale = current_user.company.sales.build(sale_params)
    @sale.user_id = current_user.id
    @sale.sku = Product.find(@sale.product_id).sku
    return redirect_to sale_path(@sale) if @sale.save

    render :new
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

    redirect_to sales_path
  end

  private

  def sale_params
    params.require(:sale).permit(:product_id, :quantity, :price, :total_quantity, :total_value, :payment_method, :payment_split, :others)
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
