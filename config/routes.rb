Rails.application.routes.draw do
  root 'homes#index'

  resources :products
end
