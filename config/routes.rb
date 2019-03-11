Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'
  get 'programming' => 'home#index'
  get 'products' => 'product#index'
  get 'order' => 'order#index'
  get 'login' => 'order#login'
  get 'register' => 'order#register'
  get 'payment' => 'order#payment'
end
