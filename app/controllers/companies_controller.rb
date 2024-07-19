class CompaniesController < ApplicationController
  #before_action :authenticate_user!
  before_action :find_company, only: [:show, :edit, :update, :destroy]

  def index
    return find_companies if params[:filter_value].present?
    @companies = Company.all.order(updated_at: :desc)
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    return redirect_to company_path(@company) if @company.save

    render :new
  end

  def show
  end

  def edit
  end

  def update
    return redirect_to company_path(@company) if @company.update(company_params)

    render :edit
  end

  def destroy
    @company.destroy!

    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name,:address,:city,:state,:zip_code,:cnpj)
  end

  def find_company
    @company = Company.find(params[:id])
  end

  def find_companies
    @companies = Company.where("#{params[:filter_column]}::text LIKE ?", "%#{params[:filter_value]}%")
  end

end
