
			Rails.application.routes.draw do
  
            namespace 'api' do
            	namespace 'v1' do
            		resources :articles
            	end
            end

			get 'welcome/index'

			    resources :users
			    resources :articles do
			    resources :comments
			end
            	post 'users/checklogin'
		        post 'users/create'
		  	    root 'welcome#index'
          
			end