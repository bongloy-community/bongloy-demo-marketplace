Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :products do
    resources :charges, only: %i[new create]
  end

  namespace :dashboard do
    resources :products do
      member do
        delete :delete_attachment
      end
    end
    resources :users, only: :index do
      resources :transaction, only: %i[index]
    end
  end

  resources :users, only: :index do
    resources :transaction, only: %i[index]
  end
end
