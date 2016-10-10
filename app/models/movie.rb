require 'httparty'
class Movie < ApplicationRecord
	has_many :movie_director
	belongs_to :rating
	validates_numericality_of :year, greater_than: 1888, less_than: Time.now.year
	validates_numericality_of :runtime, greater_than: 0
	#validates :movie_title, :year, :best_picture_winner, :best_picture_nominee, :runtime, :seen, :foreign, presence: true
	
	after_save :winner_is_nominee

	def poster
		response = HTTParty.get("http://www.omdbapi.com/?t=" + URI.encode(movie_title) + "&y=" + year.to_s)
		response["Poster"] ? response["Poster"] : false
	end

	def directors
		directors = []
		MovieDirector.where(movie_id: id).each do |md|
			d = md.director
			directors.push(d) unless directors.include?(d)
		end
		directors
	end

	def director_exists?(director_id)
		directors.include?(Director.find(director_id))
	end

	def winner_is_nominee
		best_picture_nominee = true if best_picture_winner?
	end
end
