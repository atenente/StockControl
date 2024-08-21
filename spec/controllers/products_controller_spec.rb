require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:company) { create(:company) }
  let(:admin) { create(:user, role: :admin) }
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

  describe 'GET #show' do
    before do
      get :show, params: { id: product.id }
    end

    it 'returns a success response' do
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'assigns @product' do
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it 'returns a success response' do
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'assigns a new company to @product' do
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe 'POST #create' do
    it 'Params valid: creates a new product' do
      expect {
        post :create, params: { product: attributes_for(:product, company: user_user.company) }
      }.to change(Product, :count).by(1)
    end

    it 'Params valid: redirects to the new product' do
      post :create, params: { product: attributes_for(:product, company: user_user.company) }
      expect(response).to redirect_to(product_path(assigns(:product)))
    end

    it 'Params invalid: does not save the new product' do
      expect {
        post :create, params: { product: attributes_for(:product, company: user_user.company, sku: nil) }
      }.to_not change(Product, :count)
    end

    it 'Params invalid: re-renders the new template' do
      post :create, params: { product: attributes_for(:product, company: user_user.company,sku: nil) }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: { id: product.id }
    end

    it 'returns a success response' do
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested product to @product' do
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'POST #update' do
    before do
      post :update, params: { id: product.id, product: { sku: 'sku123' } }
    end

    it 'Params valid: updates the product' do
      product.reload
      expect(product.sku).to eq('sku123')
    end

    it 'Params valid: redirects to the updated product' do
      expect(response).to redirect_to(product_path(product))
    end

    it 'Params invalid: does not update the product' do
      post :update, params: { id: product.id, product: { sku: nil } }
      product.reload
      expect(product.sku).to_not eq(nil)
    end

    it 'Params invalid: re-renders the edit template' do
      post :update, params: { id: product.id, product: { sku: nil } }
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the product' do
      expect {
        delete :destroy, params: { id: product.id }
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to product#index' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(products_path)
    end
  end
end
