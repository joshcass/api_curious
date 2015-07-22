Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: [:show]

  resources :tweets, only: [:create]
  post '/tweets/:id/favorite', to: 'tweets#favorite', as: 'favorite_tweet'
  post '/tweets/:id/unfavorite', to: 'tweets#unfavorite', as: 'unfavorite_tweet'
  post '/tweets/:id/retweet', to: 'tweets#retweet', as: 'retweet_tweet'
  post '/tweets/search', to: 'tweets#search', as: 'search_tweets'
  post '/tweets/reply', to: 'tweets#reply', as: 'reply_tweet'
  get 'tweets/:id/refresh', to: 'tweets#refresh'

end

