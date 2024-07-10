class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
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
    @product.destroy!

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:sku, :description, :price, :stock, :supplier, :size, :color, :kind)
  end

  def find_product
    @product = Product.find(params[:id])
  end

end