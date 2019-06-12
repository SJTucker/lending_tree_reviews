Rails.application.routes.draw do
	namespace :api do
		get 'reviews' => 'reviews#show'
	end
end
