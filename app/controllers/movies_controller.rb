class MoviesController < ApplicationController	
	def index
	end

	def new
	end

	def create
		Movie.create(params[:movie]);
		redirect_to movies_path
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def update
		Movie.find(params[:id]).update!(movie_params)
		redirect_to movies_path
	end

	def movie_params
		params.require(:movie).permit(:movie_title, :year, :best_picture_winner, :best_picture_nominee, :runtime, :seen, :subtitles, :rating_id)
	end
end
