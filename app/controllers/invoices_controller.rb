class InvoicesController < ApplicationController
  before_action :find_invoice, only: [:destroy]

  def create
    @sales = current_user.company.sales.where(invoice_id: nil, user_id: current_user.id)
    return redirect_to new_sale_path, alert: t('messages.invoice_empty') if @sales.empty?
    invoice = current_user.company.invoices.build(invoice_params)
    invoice.user_id = current_user.id

    if invoice.save
      redirect_to new_sale_path, notice: t('messages.success')
    else
      redirect_to new_sale_path, alert: t('messages.failure')
    end
  end

  def destroy
    @invoice.destroy

    redirect_to sales_path
  end

  private

  def invoice_params
    params.require(:invoice).permit(:payment_method, :payment_local, :payment_split)
  end

  def find_invoice
    @invoice = current_user.company.invoices.find(params[:id])
  rescue
    redirect_to root_path, alert: t('messages.not_found')
  end
end
