require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:company) { create(:company) }
  let(:user_user) { create(:user, role: :user, company: company) }
  let!(:product) { create(:product, company: company) }

  before do
    sign_in user_user
  end

  describe "GET #index" do
    context "without filter params" do
      it "assigns all products of the current user's company as @products" do
        get :index
        expect(assigns(:products)).to eq([product])
      end
    end

    context "with filter params" do
      it "filters products by specified column and value" do
        get :index, params: { filter_column: 'sku', filter_value: product.sku }
        expect(assigns(:products)).to eq([product])
      end
    end
  end


end
