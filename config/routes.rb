Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :products, only: :show do
    resources :charges, only: %i[new create]
  end

  namespace :dashboard do
    resources :products do
      member do
        delete :delete_attachment
      end
    end

    resources :orders, only: %i[index show]
    resources :users, only: %i[destroy show]
    resources :bongloy_connects, only: %i[new]
    get "bongloy_connects/authorize" => "bongloy_connects#authorize"
  end

  post "webhook/deauthorize" => "webhook#deauthorize"
end
