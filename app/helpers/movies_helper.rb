module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
	def title_active?(key)
		if key == 'title'
			"hilite"
		else
			"lolite"
		end
	end
	def release_date_active?(key)
		if key == 'release_date'
			"hilite"
		else
			"lolite"
		end
	end
	def checked?(checked_ratings, rating)
		checked_ratings.include?(rating)

	end
end
