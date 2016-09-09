class Movie < ApplicationRecord

	validates_numericality_of :year, greater_than: 1888, less_than: Time.now.year
	validates_numericality_of :runtime, greater_than: 0
	
	after_save :winner_is_nominee

	def winner_is_nominee
		best_picture_nominee = true if best_picture_winner?
	end
end
