Rails.application.routes.draw do
  root 'home#index'
  get '/diceroll', to: 'random#show'
  get '/filter', to: 'random#filter'

  resources :movies do
	collection do
    	get '/:id/tags', to: 'movies#manage_tags'
  	end
  end

  resources :tags do
  	collection do
  		get '/:str/search', to: 'tags#search'
  	end
  end

  resources :directors, :movie_directors
end
