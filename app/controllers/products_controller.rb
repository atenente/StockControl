class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    return find_products if params[:filter_value].present?
    @products = current_user.company.products
  end

  def new
    @product = current_user.company.products.build
  end

  def create
    @product = current_user.company.products.build(product_params)
    return redirect_to product_path(@product) if @product.save

    render :new
  end

  def show
  end

  def edit
  end

  def update
    return redirect_to product_path(@product) if @product.update(product_params)

    render :edit
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:sku, :description, :price, :stock, :supplier, :size, :color, :kind)
  end

  def find_product
    @product = current_user.company.products.find(params[:id])
  rescue
    redirect_to root_path, alert: t('messages.not_found')
  end

  def find_products
    column = params[:filter_column]
    value = params[:filter_value]
    if %w[stock price].include?(column)
      @products = Product.where("company_id = ? AND #{column} = ?", current_user.company_id, value.to_f)
    else
      @products = Product.where("company_id = ? AND #{column} LIKE ?", current_user.company_id,"%#{value}%")
    end
  end

end
