
			Rails.application.routes.draw do
  get 'session/new'

			get 'welcome/index'

			resources :users
			resources :articles do
			resources :comments
			end

			post 'users/login'
			post 'users/signup'
			post 'users/checklogin'
			post 'users/new'
			post 'users/logout'
		    post 'users/create'
		  	root 'welcome#index'
          
			end