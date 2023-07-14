Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  namespace :admin do
    resources :users
  end

  resources :tasks
  root to: 'tasks#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
