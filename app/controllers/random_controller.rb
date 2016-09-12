class RandomController < ApplicationController
	def show
		logger.debug(params)
		get_random_movie
		get_date_range
	end

	def get_random_movie
		movie_list = Movie.all
		@movie = movie_list.count == 0 ? false : movie_list[rand(0..movie_list.count-1)]
	end

	def get_date_range
		movies_by_year = Movie.all.order(:year)
		first = Movie.first.year/10*10
		last = Movie.last.year/10*10

		@decade_array = []
		(first..last).step(10) do |decade|
			@decade_array.push({"id": decade, "decade": decade.to_s+"s"})
		end
	end

	def filter
		redirect_to diceroll_path(filter_params)
	end

	def filter_params
		params.require(:filter).permit(:rating, :director, :year, :subtitles, :seen)
	end
end