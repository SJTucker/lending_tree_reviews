class API::ReviewsController < ApplicationController
	before_action :require_url

	def show
		reviews = ::Reviews::Scraper.new(reviews_url, limit).scrape_reviews 
		render json: reviews
	rescue Errno::ENOENT => e
		bad_request
	rescue StandardError => e
		standard_error(e)
	end

	private
		def reviews_url
			request.query_parameters[:url]
		end

		def limit
			request.query_parameters[:limit] || 15
		end

		def bad_request
			render json: { 
				error: "Your url request was malformed, and we could not gather your reviews - #{reviews_url}"
			}, status: :bad_request
		end

		def require_url
			return if reviews_url

			render json: {
				error: "Your request did not include the required \'url\' query parameter"
			}, status: :bad_request
		end

		def standard_error(e)
			render json: {
				error: e.to_s
			}, status: :internal_server_error
		end
end
