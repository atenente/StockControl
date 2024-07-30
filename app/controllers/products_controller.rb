class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    return find_products if params[:filter_value].present?
    @products = Product.where(company_token: current_user.company_token).order(updated_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params.merge(company_token: current_user.company_token))
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
    @product = Product.find_by(id: params[:id], company_token: current_user.company_token)
  end

  def find_products
    column = params[:filter_column]
    value = params[:filter_value]
    if %w[stock price].include?(column)
      @products = Product.where("company_token = ? AND #{column} = ?", current_user.company_token, value.to_f)
    else
      @products = Product.where("company_token = ? AND #{column} LIKE ?", current_user.company_token,"%#{value}%")
    end
  end

end
