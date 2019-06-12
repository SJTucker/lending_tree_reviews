class ReviewsController < ApplicationController
	def show
		reviews = `~/code/lending_tree_reviews/reviews_scraper/reviews_scraper.py` 
		binding.pry
	end
end
