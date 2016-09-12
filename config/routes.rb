Rails.application.routes.draw do
  root 'home#index'
  get '/diceroll', to: 'random#show'

  resources :movies do
	collection do
    	get 'show_list'
  	end
  end
end
