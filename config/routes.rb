Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  resources :products
  resources :companies
  resources :invoices
  resources :sales
end
