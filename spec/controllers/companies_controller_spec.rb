require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let!(:companies) { create(:company, :company_2) }
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'With role admin' do
      before do
        sign_in admin
        get :index
      end

      it 'Should show companies all' do
        expect(response).to be_successful
        expect(response).to render_template(:index)
        expect(assigns(:companies).count).to eq(2)
      end

      it 'assigns filtered companies to @companies' do
        get :index, params: { filter_column: 'name', filter_value: 'company2' }
        expect(assigns(:companies).map(&:name)[0]).to eq('company2')
      end
    end
  end

  describe 'GET #show' do
    context 'With role admin' do
      before do
        sign_in admin
        get :show, params: { id: companies.id }
      end

      it 'returns a success response' do
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end

      it 'assigns @company' do
        expect(assigns(:company)).to eq(companies)
      end
    end
  end

  describe 'GET #new' do
    context 'With role admin' do
      before do
        sign_in admin
        get :new
      end

      it 'returns a success response' do
        expect(response).to be_successful
        expect(response).to render_template(:new)
      end

      it 'assigns a new company to @company' do
        expect(assigns(:company)).to be_a_new(Company)
      end
    end
  end

  describe 'POST #create' do
    context 'With role admin' do
      before do
        sign_in admin
      end

      it 'Params valid: creates a new company' do
        expect {
          post :create, params: { company: attributes_for(:company) }
        }.to change(Company, :count).by(1)
      end

      it 'Params valid: redirects to the new company' do
        post :create, params: { company: attributes_for(:company) }
        expect(response).to redirect_to(company_path(assigns(:company)))
      end

      it 'Params invalid: does not save the new company' do
        expect {
          post :create, params: { company: attributes_for(:company, name: nil) }
        }.to_not change(Company, :count)
      end

      it 'Params invalid: re-renders the new template' do
        post :create, params: { company: attributes_for(:company, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    context 'With role admin' do
      before do
        sign_in admin
        get :edit, params: { id: companies.id }
      end

      it 'returns a success response' do
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
  
      it 'assigns the requested company to @company' do
        expect(assigns(:company)).to eq(companies)
      end
    end
  end

  describe 'POST #update' do
    context 'With role admin' do
      before do
        sign_in admin
        post :update, params: { id: companies.id, company: { name: 'New Name' } }
      end

      it 'Params valid: updates the company' do
        companies.reload
        expect(companies.name).to eq('New Name')
      end

      it 'Params valid: redirects to the updated company' do
        expect(response).to redirect_to(company_path(companies))
      end

      it 'Params invalid: does not update the company' do
        post :update, params: { id: companies.id, company: { name: nil } }
        companies.reload
        expect(companies.name).to_not eq(nil)
      end

      it 'Params invalid: re-renders the edit template' do
        post :update, params: { id: companies.id, company: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'With role admin' do
      before do
        sign_in admin
      end
      it 'deletes the company' do
        expect {
          delete :destroy, params: { id: companies.id }
        }.to change(Company, :count).by(-1)
      end

      it 'redirects to companies#index' do
        delete :destroy, params: { id: companies.id }
        expect(response).to redirect_to(companies_path)
      end
    end
  end
end
