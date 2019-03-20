Rails.application.routes.draw do
  devise_for :users
  root 'home#home'
  resources :products do
    resources :charges, only: %i[new create]
  end
  resources :users, only: :index
end
