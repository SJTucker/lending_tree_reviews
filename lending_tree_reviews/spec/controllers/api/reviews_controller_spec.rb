require 'rails_helper'

describe API::ReviewsController do
	subject { get :show, params: { url: 'https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183' } }

	context 'GET show success' do
		before do
			stub_request(:get, 'https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183?pid=1').to_return status: 200, body: File.read(Rails.root.join('spec', 'support', 'stubs', 'reviews', 'reliance.html'))
			stub_request(:get, 'https://www.lendingtree.com/reviews/personal/first-midwest-bank/52903183?pid=2').to_return status: 200, body: File.read(Rails.root.join('spec', 'support', 'stubs', 'reviews', 'reliance_pg2.html'))
		end

		it 'is successful' do
			subject
			expect(response).to have_http_status :success
		end

		it 'retrieves all reviews' do
			subject
			expect(JSON.parse(response.body).length).to eq 20
		end
	end

	context 'GET show failure' do
		it 'responds with error code without url query param' do
			get :show
			expect(response).to have_http_status :bad_request
		end		

		it 'responds with error code for bad url' do
			get :show, params: { url: 'bad_url' }
			expect(response).to have_http_status :bad_request
		end
	end
end