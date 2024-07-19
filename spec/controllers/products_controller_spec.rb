require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:product) { create(:product) }
  let(:params_valid) { attributes_for(:product, sku:'Sku1234', price: 1.1, stock: 10) }
  let(:params_invalid) { attributes_for(:product, sku: '') }

  describe 'GET #index' do
    context 'when no products exist' do
      before { Product.destroy_all }
      before { get :index }

      it 'returns a success response' do
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'assigns @products' do
        expect(assigns(:products)).to be_empty
      end
    end

    context 'when products exist' do
      before { get :index }

      it 'returns a success response' do
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'assigns @products' do
        expect(assigns(:products)).to_not be_empty
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: product.id } }

    it 'returns a success response' do
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'assigns @product' do
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'returns a success response' do
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'assigns a new product' do
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new product' do
        expect {
          post :create, params: { product: params_valid }
        }.to change(Product, :count).by(1)
      end

      it 'redirects to the created product' do
        post :create, params: { product: params_valid }
        expect(response).to redirect_to(Product.last)
      end
    end

    context 'with invalid params' do
      it 'does not create a new product' do
        expect {
          post :create, params: { product: params_invalid }
        }.to_not change(Product, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { product: params_invalid }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: product.id } }

    it 'returns a success response' do
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested product as @product' do
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { sku: 'sku123' } }

      before { put :update, params: { id: product.id, product: new_attributes } }

      it 'updates the requested product' do
        product.reload
        expect(product.sku).to eq('sku123')
      end

      it 'redirects to the product' do
        expect(response).to redirect_to(product)
      end
    end

    context 'with invalid params' do
      before { put :update, params: { id: product.id, product: params_invalid } }

      it 'does not update the product' do
        product.reload
        expect(product.sku).not_to eq('')
      end

      it 're-renders the :edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { product }

    it 'destroys the requested product' do
      expect {
        delete :destroy, params: { id: product.id }
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(products_url)
    end
  end
end
