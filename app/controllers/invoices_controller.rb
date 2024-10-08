class InvoicesController < ApplicationController
  before_action :find_invoice, only: [:show, :edit, :update, :destroy]

  def index
    return find_sales if params[:filter_value].present?
    @invoices = current_user.company.invoices.includes(sales: :product).order(created_at: :desc, 'sales.id': :asc)
  end

  def show
  end

  def edit
  end

  def create
    invoice = current_user.company.invoices.build(invoice_params)
    invoice.user_id = current_user.id
    return redirect_to new_sale_path, notice: t('messages.success') if invoice.save

    redirect_to new_sale_path, alert: t('messages.failure')
  end

  def update
    return redirect_to invoice_path(@invoice), notice: t('messages.success') if @invoice.update(invoice_params)
    render :edit
  end

  def destroy
    @invoice.destroy

    redirect_to invoices_path
  end

  private

  def invoice_params
    params.require(:invoice).permit(:payment_method, :payment_local, :payment_split, :total_quantity)
  end

  def find_invoice
    @invoice = current_user.company.invoices.includes(sales: :product).find(params[:id])
  rescue
    redirect_to root_path, alert: t('messages.not_found')
  end

  def find_invoices
    column = params[:filter_column]
    value = params[:filter_value]

    @sales = Poros::Search.call(target_class: Invoice, company_id: current_user.company_id, column:, value:)
  end
end
