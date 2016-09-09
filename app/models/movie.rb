class Movie < ApplicationRecord
	after_update :winner_is_nominee

	def winner_is_nominee
		best_picture_nominee = true if best_picture_winner?
	end
end
