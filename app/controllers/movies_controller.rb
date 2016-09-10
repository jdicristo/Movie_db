class MoviesController < ApplicationController	
	def index
	end

	def new
	end

	def create
		Movie.create({movie_title: params[:movie][:movie_title], year: params[:movie][:year], runtime: params[:movie][:runtime], rating_id: params[:movie][:rating_id], seen: params[:movie][:seen], subtitles: params[:movie][:aubtitles], best_picture_nominee: params[:movie][:best_picture_nominee], best_picture_winner: params[:movie][:best_picture_winner]});
		redirect_to movies_path
	end
end
