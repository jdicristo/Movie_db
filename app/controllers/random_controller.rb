class RandomController < ApplicationController
	def show
		get_random_movie
		get_dropdownlist_values
	end

	def get_random_movie
		movie_list = Movie.all.to_a
		movie_list = movie_list.select{ |m| m.director_exists?(params[:director]) } if param_present(:director)
		movie_list = movie_list.select{ |m| m.rating_id == params[:rating].to_i } if param_present(:rating)
		movie_list = movie_list.select{ |m| m.year >= params[:year].to_i && m.year < params[:year].to_i + 10 } if param_present(:year)
		movie_list = filter_bool(movie_list, :subtitles) if param_present(:subtitles)
		movie_list = filter_bool(movie_list, :seen) if param_present(:seen)
		movie_list = filter_runtime(movie_list) if param_present(:runtime_min)
		@movie = movie_list.count == 0 ? false : movie_list[rand(0..movie_list.count-1)]
	end

	def get_dropdownlist_values
		@directors = Director.all.sort_by { |d| d[:name].sub(/^the /i,"").downcase }
		get_year_list
		@ratings = Rating.all
		@bool_list = [["Any",0], ["No",1], ["Yes",2]]
		@runtimes_min = [["Any",0], ["30 minutes",30], ["1 hour", 60], ["1 hour 30 minutes", 90], ["2 hours", 120], ["2 hours 30 minutes", 150], ["3 hours", 180]]
		@runtimes_max = [["Any",999], ["30 minutes",30], ["1 hour", 60], ["1 hour 30 minutes", 90], ["2 hours", 120], ["2 hours 30 minutes", 150], ["3 hours", 180]]
	end

	def filter_bool(list, attribute)
		if params[attribute] == "1"
			list.select{ |m| !m[attribute] }
		elsif params[attribute] == "2"
			list.select{ |m| m[attribute] }
		else
			list
		end
	end

	def filter_runtime(list)
		min = params[:runtime_min]
		max = params[:runtime_max]
		min < max ? list.select{ |m| m.runtime >= min.to_i && m.runtime <= max.to_i } : list
	end

	def get_year_list
		movies_by_year = Movie.all.order(:year)
		first = movies_by_year.first.year/10*10
		last = movies_by_year.last.year/10*10

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
		params.require(:filter).permit(:rating, :director, :year, :subtitles, :seen, :runtime_min, :runtime_max)
	end
end