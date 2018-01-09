Rails.application.routes.draw do	
  get 'welcome/index'
  resources :users
  resources :articles 
  resources :comments
  post 'users/checklogin'
  post 'users/create'
  post 'users/logout'
  root 'welcome#index'
end