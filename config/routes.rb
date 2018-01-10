Rails.application.routes.draw do	
	get 'welcome/index'
	post 'users/checklogin'
	post 'users/logout'
	resources :users
	resources :articles 
	resources :comments
	root 'welcome#index'
end