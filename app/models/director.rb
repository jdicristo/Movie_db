class Director < ApplicationRecord
	#has_many :movie_directors, dependant: :destroy

	def movies
		MovieDirector.where(director_id: id).map{ |m| Movie.find(m.movie_id)}
	end
end
