Rails.application.routes.draw do
  root 'home#index'
  get '/diceroll', to: 'random#show'
  get '/filter', to: 'random#filter'

  resources :movies do
	collection do
    	get '/:id/tags', to: 'movies#manage_tags'
  	end
  end
  resources :directors, :tags, :movie_directors
end
