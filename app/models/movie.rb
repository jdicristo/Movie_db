require 'httparty'
class Movie < ApplicationRecord
	validates_numericality_of :year, greater_than: 1888, less_than: Time.now.year
	validates_numericality_of :runtime, greater_than: 0
	#validates :movie_title, :year, :best_picture_winner, :best_picture_nominee, :runtime, :seen, :foreign, presence: true
	
	after_save :winner_is_nominee

	def poster
		response = HTTParty.get("http://www.omdbapi.com/?t=" + URI.encode(movie_title) + "&y=" + year.to_s)
		response["Poster"] ? response["Poster"] : false
	end

	def winner_is_nominee
		best_picture_nominee = true if best_picture_winner?
	end
end
