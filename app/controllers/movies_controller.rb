class MoviesController < ApplicationController	
	def index
		@movies = Movie.all.sort_by { |m| m[:movie_title].sub(/^the /i,"").downcase }
	end

	def new
	end

	def create
		m = Movie.create(movie_params)
		MovieDirector.create({movie_id: m.id, director_id: params[:movie_director][:director_id]})
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

	def director_params
		params.require(:movie_director).permit(:director_id)
	end

	def sort_list
		logger.debug(params)
	end

	def destroy
	    @movie = Movie.find(params[:id])
	    @movie.destroy

	    redirect_to movies_path
	end
end