describe ::Reviews::Scraper do
	subject { klass.new 'https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183' }

	before do
		stub_request(:get, 'https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183?pid=1').to_return status: 200, body: File.read(Rails.root.join('spec', 'support', 'stubs', 'reviews', 'reliance.html'))
		stub_request(:get, 'https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183?pid=2').to_return status: 200, body: File.read(Rails.root.join('spec', 'support', 'stubs', 'reviews', 'reliance_pg2.html'))
	end

	context '#scrape_reviews' do
		it 'retrieves reviews for given url' do
			reviews = subject.scrape_reviews
			expect(reviews.length).to eq 20
		end

		it 'parses reviews correctly' do
			review = subject.scrape_reviews[0]
			expect(review[:title]).to eq 'Great experience!'
			expect(review[:body]).to include('Donna was great throughout the process.')
			expect(review[:rating]).to eq '(5 of 5)'
			expect(review[:author]).to eq 'Tina'
			expect(review[:location]).to eq 'Nottingham, MD'
			expect(review[:date]).to eq 'June 2019'
			expect(review[:closedWithLender]).to eq 'Yes'
			expect(review[:loanType]).to eq 'Refinance'
			expect(review[:reviewType]).to eq 'Loan Officer Review'
		end
	end
end
