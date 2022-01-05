Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :transactions, only: [:create]
      resources :balances, only: [:index]
      patch '/balances', to: 'balances#edit'
    end
  end
end
