class RandomController < ApplicationController
	def show
		get_random_movie
		get_dropdownlist_values
	end

	def get_random_movie
		movie_list = Movie.all.to_a
		movie_list = filter_director(movie_list)
		movie_list = filter_rating(movie_list)
		movie_list = filter_year(movie_list)
		movie_list = filter_subtitles(movie_list)
		movie_list = filter_seen(movie_list)
		@movie = movie_list.count == 0 ? false : movie_list[rand(0..movie_list.count-1)]
	end

	def get_dropdownlist_values
		get_director_list
		get_year_list
		get_rating_list
	end

	def filter_director(list)
		param_present(:director) ? list.select{ |m| m.director_exists?(params[:director]) } : list
	end
	
	def filter_rating(list)
		param_present(:rating) ? list.select{ |m| m.rating_id == params[:rating].to_i } : list
	end

	def filter_year(list)
		param_present(:year) ? list.select{ |m| m.year >= params[:year].to_i && m.year < params[:year].to_i + 10 } : list
	end
		
	def filter_subtitles(list)
		if params[:subtitles] == "1"
			list.select{ |m| !m.subtitles }
		elsif params[:subtitles] == "2"
			list.select{ |m| m.subtitles }
		else
			list
		end

	end

	def filter_seen(list)
		if params[:seen] == "1"
			list.select{ |m| !m.seen }
		elsif params[:seen] == "2"
			list.select{ |m| m.seen }
		else
			list
		end
	end

	def get_director_list
		@directors = Director.all.sort_by { |d| d[:name].sub(/^the /i,"").downcase }
	end

	def get_rating_list
		@ratings = Rating.all
	end

	def get_year_list
		movies_by_year = Movie.all.order(:year)
		first = movies_by_year.first.year/10*10
		last = movies_by_year.last.year/10*10
		logger.debug(first)
		logger.debug(last)

		@decade_array = []
		(first..last).step(10) do |decade|
			@decade_array.push({"id": decade, "decade": decade.to_s+"s"})
		end
	end

	def param_present(p)
		!params[p].nil? && !params[p].empty?
	end

	def filter
		redirect_to diceroll_path(filter_params)
	end

	def filter_params
		params.require(:filter).permit(:rating, :director, :year, :subtitles, :seen)
	end
end