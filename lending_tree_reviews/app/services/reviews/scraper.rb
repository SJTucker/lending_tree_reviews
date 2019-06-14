require 'nokogiri'
require 'open-uri'

module Reviews
	class Scraper
		def initialize(url)
			@base_url = url
			@more_reviews = true
			@page_number = 0
			@reviews = []
		end

		def scrape_reviews
			while @more_reviews do
				@page_number += 1
				
				request_page
				@reviews << reviews_set

				print "*#{@page_number}*"
			end

			@reviews.flatten
		end

		def request_page
			url = "#{@base_url}?pid=#{@page_number}"
			@html = Nokogiri::HTML.parse(open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))

			@more_reviews = false unless @html.css('.lenderNav').at('a:contains("Next")')
			#@more_reviews = false if @page_number == 5
		end

		def review_panels
			@html.css('.mainReviews')
		end

		def reviews_set
			set = []
			review_panels.each do |review|
				consumer = review.css('.consumerName').text.split('from')
				review_points = review.css('.reviewPoints')

				rev = {	
					title: review.css('.reviewTitle').text.strip,
					body: review.css('.reviewText').text.strip,
					rating: review.css('.numRec').text.strip,
					author: consumer[0].strip,
					location: consumer[1].strip,
					date: review.css('.consumerReviewDate').text.split('in')[1].strip,
					closedWithLender: review_points.css('.yes') ? 'Yes' : 'No',
					loanType: review_points.css('.loanType')[0].text.strip,
					reviewType: review_points.css('.loanType')[1].text.strip
				}

				set << rev
			end

			set
		end
	end
end