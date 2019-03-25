Rails.application.routes.draw do
  devise_for :users
  root "home#home"
  get "items/:id" => "home#show", as: :product_detail
  namespace :dashboard do
    resources :products do
      resources :charges, only: %i[new create]
      member do
        delete :delete_attachment
      end
    end
  end
  resources :users, only: :index
end
