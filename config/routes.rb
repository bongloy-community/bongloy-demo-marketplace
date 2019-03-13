Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'
  resources :products
  get 'order' => 'order#index'
  get 'payment' => 'order#payment'
  resources :users, only: :index
end
