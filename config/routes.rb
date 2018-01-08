Rails.application.routes.draw do	
  get 'welcome/index'
  resources :users
  resources :articles do
    resources :comments
  end
  post 'users/checklogin'
  post 'users/create'
  root 'welcome#index'
end