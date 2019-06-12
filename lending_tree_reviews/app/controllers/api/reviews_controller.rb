class API::ReviewsController < ApplicationController
	def show
		reviews = ::Reviews::Scraper.new(request.query_parameters[:url]).scrape_reviews 
		render json: reviews
	end
end
