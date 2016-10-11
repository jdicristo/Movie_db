class MoviesController < ApplicationController	
	helper_method :sort_column, :sort_direction

	def index
		#@movies = Movie.all.sort_by { |m| m[:movie_title].sub(/^the /i,"").downcase }.paginate(page: params[:page], per_page: 2)
		@movies = Movie.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
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

	def manage_tags
		@movie = Movie.find(params[:id])
	end

	def movie_params
		params.require(:movie).permit(:movie_title, :year, :best_picture_winner, :best_picture_nominee, :runtime, :seen, :subtitles, :rating_id)
	end

	def director_params
		params.require(:movie_director).permit(:director_id)
	end

	def destroy
	    @movie = Movie.find(params[:id])
	    @movie.destroy

	    redirect_to movies_path
	end

	private 

	def sort_column
		Movie.column_names.include?(params[:sort]) ? params[:sort] : "movie_title"
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
end