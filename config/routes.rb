Rails.application.routes.draw do
  root 'home#index'
  get '/diceroll', to: 'random#show'

  resources :movies
end
