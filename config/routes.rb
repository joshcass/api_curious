Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:show]
end

