class RandomController < ApplicationController
	def show
		movie_list = Movie.all
		rand = rand(0..movie_list.count-1)
		@movie = movie_list[rand]
	end
end