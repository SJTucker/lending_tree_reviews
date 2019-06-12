Rails.application.routes.draw do
	namespace :api do
		get 'reviews/:url' => 'reviews#show', :constraints => {:url => /.*/}
	end
end
