class SalesController < ApplicationController
  before_action :load_sale, :load_sales, only: [:new, :create]
  before_action :find_sale, only: [:destroy]

  def new
  end

  def create
    @sale.user_id = current_user.id
    invoice_id = params[:sale][:invoice_id].to_i
    if @sale.save
      return redirect_to invoice_path(invoice_id), notice: t('messages.success') if !invoice_id.zero?
      redirect_to new_sale_path, notice: t('messages.success')
    else
      return redirect_to invoice_path(invoice_id), alert: t('messages.failure') if !invoice_id.zero?
      render :new
    end
  end

  def destroy
    @sale.destroy
    redirect_back(fallback_location: sales_path, notice: t('messages.destroy_success'))
  end

  private

  def load_sales(invoice = params[:id], user = current_user.id)
    @sales = current_user.company.sales.includes(:product).where(invoice_id: invoice)
    unless invoice
      @sales = @sales.where(user_id: user)
    end
  end

  def load_sale(sale_params = nil)
    sale_params = params[:sale].permit(:product_id, :quantity, :invoice_id) if params[:sale].present?
    @sale = current_user.company.sales.includes(:product).build(sale_params)
  end

  def sale_params
    params.require(:sale).permit(:product_id, :quantity, :invoice_id)
  end

  def find_sale
    @sale = current_user.company.sales.find(params[:id])
  rescue
    redirect_to root_path, alert: t('messages.not_found')
  end

end
