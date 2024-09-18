class InvoicesController < ApplicationController
  before_action :find_invoice, only: [:show, :update, :destroy]

  def create
    @sales = current_user.company.sales.where(invoice_id: nil, user_id: current_user.id)
    return redirect_to new_sale_path, alert: t('messages.invoice_empty') if @sales.empty?

    @invoice = Invoice.new(invoice_params)
    @invoice.total_quantity = current_user.company.sales.where(user_id: current_user.id).sum(:quantity)
    @invoice.total_value = current_user.company.sales.where(user_id: current_user.id).sum(:sum_price)
    @invoice.user_id = current_user.id
    @invoice.company_id = current_user.company_id

    if @invoice.save
      @sales.update_all(invoice_id: @invoice.id)
      redirect_to new_sale_path, notice: t('messages.success')
    else
      redirect_to new_sale_path, alert: t('messages.failure')
    end
  end

  def show
  end

  def update
    return redirect_to sale_path(@invoice) if @invoice.update(sale_params)

    render :edit
  end

  def destroy
    @invoice.destroy

    redirect_to new_sale_path
  end

  private

  def invoice_params
    params.require(:invoice).permit(:payment_method, :payment_local, :payment_split)
  end

  def find_invoice
    @invoice = current_user.company.sales.find(params[:id])
  rescue
    redirect_to root_path, alert: t('messages.not_found')
  end
end
